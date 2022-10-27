require 'rails_helper'

describe Warehouse do
    context '.all' do
        it 'deve retornar todos os galpões' do
            #Arrange
            json_data = File.read(Rails.root.join('spec/support/json/warehouses.json'))
            fake_response = double("faraday_response", status: 200, body: json_data)    
            
            allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/warehouses').and_return(fake_response)
            #Act
            result = Warehouse.all
            #Assert
            expect(result.length).to eq 2
            expect(result[0].name).to eq 'Galpão SP'
            expect(result[0].code).to eq 'GRU'
            expect(result[0].city).to eq 'São Paulo'
            expect(result[0].address).to eq 'Av Paulista, 1000'
            expect(result[0].cep).to eq '80000-000'
            expect(result[0].description).to eq 'Galpão SP'
            expect(result[0].state).to eq 'SP'
            
            
            expect(result[1].name).to eq 'Aeroporto Rio'
            expect(result[1].code).to eq 'SDU'
        end

        it 'deve retornar vazio se a API está indisponível' do
           fake_response = double("faraday_resp", status: 500, body: "{}") 
           allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/warehouses').and_return(fake_response)

           result = Warehouse.all

           expect(result).to eq []
        end
    end
end

