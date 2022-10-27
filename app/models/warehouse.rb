class Warehouse
    attr_accessor :id, :name, :code, :address, :city, :description, :area, :cep, :state
    
    def initialize(id:, name:, code:, address:, city:, description:, area:, cep:, state:)
        @id = id
        @name = name
        @code = code
        @address = address
        @city = city
        @description = description
        @area = area
        @cep = cep
        @state = state
    end
    

    def self.all
        warehouses= []
        response = Faraday.get('http://localhost:4000/api/v1/warehouses')
        if response.status == 200
        data = JSON.parse(response.body)
        data.each do |d|
            warehouses << Warehouse.new(id: d["id"], name: d["name"], code: d["code"], address: d["address"], city: d["city"], description: d["description"], area: d["area"], cep: d["cep"], state: d["state"])
        end
    end

        
        warehouses
    end
end