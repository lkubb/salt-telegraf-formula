# frozen_string_literal: true

control 'telegraf.package.install' do
  title 'The required package should be installed'

  package_name = 'telegraf'

  describe package(package_name) do
    it { should be_installed }
  end
end
