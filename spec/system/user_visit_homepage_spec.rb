require 'rails_helper'

describe 'Usuário visita tela inicial' do

it 'e vê galpões' do
#Arrange
json_data = File.read(Rails.root.join('spec/support/json/warehouses.json'))
fake_response = double("faraday_response", status: 200, body: json_data)

allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/warehouses').and_return(fake_response)
#Act
visit root_path
#Assert
expect(page).to have_content 'E-Commerce App'
expect(page).to have_content 'Aeroporto Rio'
expect(page).to have_content 'Galpão SP'

    end

    it 'e não existe galpões' do

    json_data = File.read(Rails.root.join('spec/support/json/warehouses.json'))
    fake_response = double("faraday_response", status: 200, body: "[]")

    allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/warehouses').and_return(fake_response)
    #Act
    visit root_path
    #Assert
    expect(page).to have_content 'Nenhum galpão encontrado'
    end

    it 'e vê detalhes de galpão' do

        json_data = File.read(Rails.root.join('spec/support/json/warehouses.json'))
        fake_response = double("faraday_response", status: 200, body: json_data)    
        allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/warehouses').and_return(fake_response)

        json_data = File.read(Rails.root.join('spec/support/json/warehouse.json'))
        fake_response = double("faraday_response", status: 200, body: json_data)
        allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/warehouses/1').and_return(fake_response)

        visit root_path

        click_on 'Galpão SP'
        
        expect(page).to have_content 'Aeroporto Rio - SDU'
        expect(page).to have_content 'Rio de Janeiro'
        expect(page).to have_content '60000 m²'
        expect(page).to have_content 'Av do Porto, 1000'
        expect(page).to have_content 'Galpão Rio'
    end

    it 'e não é possível carregar o galpão' do

        json_data = File.read(Rails.root.join('spec/support/json/warehouses.json'))
        fake_response = double("faraday_response", status: 200, body: json_data)    
        allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/warehouses').and_return(fake_response)

        
        error_response = double("faraday_response", status: 500, body: "{}")
        allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/warehouses/1').and_return(error_response)

        visit root_path

        click_on 'Galpão SP'
        
        expect(page).to have_content 'Não foi possível carregar o galpão'
        expect(current_path).to eq root_path
        
    end
end