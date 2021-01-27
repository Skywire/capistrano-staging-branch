require 'net/http'
require 'uri'
require 'json'

uri = URI.parse("https://skywire-slack-staging-branch.herokuapp.com/branch/")
request = Net::HTTP::Post.new(uri)
request.content_type = "application/json"
request["Accept"] = "application/json"
puts request.body
req_options = {
    use_ssl: uri.scheme == "https",
}

namespace :stagingbranch do
  desc "Write the checkout out branch to a .branch file so it can be read by the staging branch script"
  task :reserve do
    on release_roles :all do
      within release_path do
        execute "echo \"#{fetch(:branch, "master")}\" > #{release_path}/.branch"
        request.body = {
            channel: fetch(:channel, "stagingbranch"),
            site: fetch(:site, "none"),
            branch: fetch(:branch, "master")
        }.to_json
        Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
          http.request(request)
        end
      end
    end
  end
  task :free do
    on release_roles :all do
      within release_path do
        execute "echo master > #{release_path}/.branch"
      end
    end
  end
end

after "deploy:published", "stagingbranch:reserve"
