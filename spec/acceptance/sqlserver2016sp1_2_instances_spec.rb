# Encoding: utf-8
require_relative 'spec_windowshelper'

describe package('Microsoft SQL Server 2016 (64-bit)') do
  it { should be_installed }
end

['SQL2016_1', 'SQL2016_2'].each do |instance_name|

  describe service("MSSQL$#{instance_name}") do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
    it { should have_start_mode('Automatic') }
  end

  describe windows_registry_key("HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Microsoft SQL Server\\MSSQL13.#{instance_name}\\Setup") do
    it { should exist }
    it { should have_property_value('PatchLevel', :type_string, '13.1.4001.0') }
  end
end
