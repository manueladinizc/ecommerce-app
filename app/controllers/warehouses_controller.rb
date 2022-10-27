class WarehousesController < ApplicationController
def index
    @warehouses = []
    #Conectar na API, acessar  endpoint de galpões, receber o JSON, tratar JSON
    response = Faraday.get('http://localhost:4000/api/v1/warehouses')
    #install gem faraday, next get http from warehouse-app
    @warehouses = JSON.parse(response.body)
end

def show
    id = params[:id]
    response = Faraday.get("http://localhost:4000/api/v1/warehouses/#{id}")
    if response.status == 200
        @warehouse = JSON.parse(response.body)
    else
        redirect_to root_path, notice: "Não foi possível carregar o galpão"
    end
end

end