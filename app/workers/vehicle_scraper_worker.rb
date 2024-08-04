require 'faraday'
require 'json'
require 'mechanize'
require 'faraday-cookie_jar'

class VehicleScraperWorker
  include Sidekiq::Worker

  def perform(options = {})
    task = options["task"].nil? ? Task.find(options[:task]) : Task.find(options["task"])
    vehicles = []
    vehicle_type = options["vehicle_type"] || 'carros-novos'
    display_per_page = 50
    max_pages = 2

    agent = Mechanize.new
    agent.user_agent_alias = 'Windows Chrome'

    headers = {
      'Accept' => 'application/json, text/plain, */*',
      'Accept-Language' => 'pt-BR,pt;q=0.9,en-US;q=0.8,en;q=0.7',
      'Connection' => 'keep-alive',
      'Sec-Fetch-Dest' => 'empty',
      'Sec-Fetch-Mode' => 'cors',
      'Sec-Fetch-Site' => 'same-origin',
      'User-Agent' => 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36',
      'X-Channel-Id' => 'webmotors.buyer.desktop.ui',
      'sec-ch-ua' => '"Not)A;Brand";v="99", "Google Chrome";v="127", "Chromium";v="127"',
      'sec-ch-ua-mobile' => '?0',
      'sec-ch-ua-platform' => '"Windows"'
    }

    (1..max_pages).each do |page|
      url = "https://www.webmotors.com.br/api/search/car?url=https://www.webmotors.com.br/#{vehicle_type}/estoque?lkid=1000&actualPage=#{page}&displayPerPage=#{display_per_page}&order=1&showMenu=true&showCount=true&showBreadCrumb=true&testAB=false&returnUrl=false&pandora=true"

      begin
        response = agent.get(url, [], nil, headers)

        if response.code.to_i == 200
          notification(task, "in_progress")

          data = JSON.parse(response.body)
          data['SearchResults'].each do |item|
            vehicle = Vehicle.create(
              model: item["Specification"]["Model"]["Value"],
              brand: item["Specification"]["Make"]["Value"],
              price: item["Prices"]["Price"],
              task_id: task.id
            )
            vehicles << vehicle
          end
          puts "concluido"
        end
      rescue => e
        notification(task, "failure")
        puts "Erro na página #{page}: #{e.message}"
      end

      notification(task, "complete") if task.vehicles.size == 100
      sleep(120) if task.vehicles.size != 100
    end
  end

  private

  def notification(task, status)
    task.update(status: status)
    NotificationWorker.perform_async(options = {
      task_uuid: task.uuid,
      user_email: task.user_email,
      status: status
    })
  end
end
