$: << 'cf_spec'
require 'cf_spec_helper'

describe 'Rails latest App' do
  subject(:app) { Machete.deploy_app(app_name, with_pg: true) }
  let(:app_name) { 'rails_latest_web_app' }

  context 'in an offline environment', if: Machete::BuildpackMode.offline? do
    specify do
      expect(app).to be_running
      expect(app.homepage_body).to include('Listing people')
      expect(app).not_to have_internet_traffic
    end
  end

  context 'in an online environment', if: Machete::BuildpackMode.online? do
    specify do
      expect(app).to be_running
      expect(app.homepage_body).to include('Listing people')
    end
  end
end
