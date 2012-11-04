# encoding: UTF-8
module MultiCommerce
  class Parser
    def initialize(data)
      @data = data
    end

    def parse
      parse_unity.each do |unity_params|
        password = generate_password(unity_params[:email])
        
        unity = Unity.find_or_create_by_code unity_params[:code]
        user = User.find_or_create_by_email(email: unity_params[:email], password: password)        
        franchise = Franchise.find_by_acronym(unity_params[:franchise_acronym])
        
        user.franchises << franchise unless user.franchises.include?(franchise)
        user.save
        
        unity.users << user unless unity.users.include?(user)
        unity.franchise = franchise
        unity.update_attributes unity_params
      end
    end
    
    def generate_password(email)
      email.split('@').first
    end
    
    # def parse
    #   parse_unity.each do |unity_params|
    #     unity = Unity.find_or_create_by_code unity_params[:code]
    #     user = User.find_or_create_by_email(email: unity_params[:email], password: unity_params[:email].split('@').first)
    #     franchise = Franchise.find_by_acronym(unity_params[:franchise_acronym])
    #     user.franchises << franchise if not user.franchises.include?(franchise)
    #     user.save
    #     unity.users << user if not unity.users.include?(user)
    #     unity.franchise = franchise
    #     unity.update_attributes unity_params
    #   end
    # end
    
    def parse_unity
      doc = Nokogiri::XML @data
      
      doc.xpath("//Table").map do |table|
        attrs = find_unity_attributes(table)
        attrs[:franchise_acronym] == "W" ? attrs : nil
      end.compact
    end
    
    private
    
    def find(attribute, node_set, capture = nil)
      node = node_set.detect { |node| node.name == attribute }
      capture ? node.text.scan(capture).first : node.text
    end
    
    def find_unity_attributes(table)
      {}.tap do |el|
        el[:code] = find "codEmitente", table.children
        el[:name] = find "nomeFantasia", table.children
        
        # el[:phone] = find "telefone", table.children
        unformatted_phone = find "telefone", table.children
        unformatted_phone =~ /(\d{2}) (\d+) (\d+)/
        el[:phone_code] = $1.to_s
        el[:phone] = $2.to_s + $3.to_s
        
        el[:email] = find "email", table.children
        # el[:address] = make_address table
        el[:address_street] = find "endereco", table.children
        el[:address_number] = find "end_num", table.children
        el[:address_district] = find "bairro", table.children
        el[:address_city] = find "cidade", table.children
        el[:address_state] = find "estado", table.children
        el[:address_zipcode] = find "cep", table.children
        # el[:address] = find "enderecoCompleto", table.children
        el[:status] = find "codStatus", table.children
        el[:situation] = find "situacao", table.children
        el[:franchise_acronym] = find "modalidade", table.children, /\w/
      end
    end
    
    def make_address(table)
      [].tap do |elements|
        elements << find("endereco", table.children)
        elements << find("end_num", table.children)
        elements << find("bairro", table.children)
        elements << find("cidade", table.children)
        elements << find("estado", table.children)
        elements << find("cep", table.children)
      end.join ", "
    end
  end
end