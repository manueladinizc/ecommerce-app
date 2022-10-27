class WarehousesController < ApplicationController
def index
    @warehouses = []
    #Conectar na API, acessar  endpoint de galpões, receber o JSON, tratar JSON
    response = Faraday.get('http://localhost:4000/api/v1/warehouses')
    #install gem faraday, next get http from warehouse-app
    @warehouses = JSON.parse(response.body)
end

end