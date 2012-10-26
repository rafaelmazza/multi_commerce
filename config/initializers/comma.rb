if defined?(ActionController::Renderers) && ActionController::Renderers.respond_to?(:add)
  ActionController::Renderers.add :csv do |obj, options|
    filename    = options[:filename] || 'data'
    #Capture any CSV optional settings passed to comma or comma specific options
    csv_options = options.slice(*CSV_HANDLER::DEFAULT_OPTIONS.merge(Comma::DEFAULT_OPTIONS).keys)
    send_data obj.to_comma(csv_options.merge(:col_sep => ';')), :type => Mime::CSV, :disposition => "attachment; filename=#{filename}.csv"
  end
end

module Comma

  class Extractor

    def initialize(instance, &block)
      @instance = instance
      @block = block
      @results = []
    end

    def results
      instance_eval &@block
      @results
    end

    def id(*args)
      method_missing(:id, *args)
    end
  end

  class HeaderExtractor < Extractor
    
    def method_missing(sym, *args, &block)
      @results << sym.to_s.humanize if args.blank?
      args.each do |arg|
        case arg
        when Hash
          arg.each do |k, v|
            @results << ((v.is_a? String) ? v : v.to_s.humanize)
          end
        when Symbol
          @results << arg.to_s.humanize
        when String
          @results << arg
        else
          raise "Unknown header symbol #{arg.inspect}"
        end
      end
    end
  end

  class DataExtractor < Extractor

    def method_missing(sym, *args, &block)
      if args.blank?
        result = block ? yield(@instance.send(sym)) : @instance.send(sym)
        @results << result.to_s
      end

      args.each do |arg|
        case arg
        when Hash
          arg.each do |k, v|
            if block
              @results << (@instance.send(sym).nil? ? '' : yield(@instance.send(sym).send(k)).to_s.encode('ISO-8859-15', 'UTF-8') )
            else
              @results << (@instance.send(sym).nil? ? '' : @instance.send(sym).send(k).to_s.encode('ISO-8859-15', 'UTF-8') )
            end
          end
        when Symbol
          if block
            @results << (@instance.send(sym).nil? ? '' : yield(@instance.send(sym).send(arg)).to_s.encode('ISO-8859-15', 'UTF-8'))
          else
            @results << ( @instance.send(sym).nil? ? '' : @instance.send(sym).send(arg).to_s.encode('ISO-8859-15', 'UTF-8') )
          end
        when String
          @results << (block ? yield(@instance.send(sym)) : @instance.send(sym)).to_s.encode('ISO-8859-15', 'UTF-8')
        else
          raise "Unknown data symbol #{arg.inspect}"
        end
      end
    end
  end
end