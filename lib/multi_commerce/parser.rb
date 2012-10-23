module MultiCommerce
  class Parser
    def initialize(data)
      @data = data
    end
    
    def parse
      parse_unity.each do |unity_params|
        unity = Unity.find_or_create_by_code unity_params[:code]
        user = User.find_or_create_by_email(email: unity_params[:email], password: unity_params[:email].split('@').first)
        franchise = Franchise.find_by_acronym(unity_params[:franchise_acronym])
        user.franchises << franchise if not user.franchises.include?(franchise)
        user.save
        unity.users << user if not unity.users.include?(user)
        unity.franchise = franchise
        unity.update_attributes unity_params
      end
    end
    
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
        el[:phone] = find "telefone", table.children
        el[:email] = find "email", table.children
        el[:address] = make_address table
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