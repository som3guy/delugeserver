# wget is installed
describe package('wget') do
  it { should be_installed }
end

# epel-release is installed
describe package('epel-release') do
  it { should be_installed }
end

# downloads directory exists
describe directory('/.downloads') do
  it { should be_directory}
end

# nux-dextop exists
describe file('/.downloads/nux-dextop-release-0-5.el7.nux.noarch.rpm') do
  it { should be_file }
end

# nux-desktop is installed
describe command('rpm -V nux-dextop-release-0-5.el7.nux.noarch') do
  its('stdout') { should eq ''}
end

# deluge-web is installed
describe package('deluge-web') do
  it { should be_installed }
end

# deluge-web service is enabled and running
describe service('deluge-web') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

# /.deluge directory exists
describe directory('/.deluge') do
  it { should be_directory }
  it { should be_owned_by 'deluge' }
  it { should be_grouped_into 'deluge' }
end

# /.deluge/prep directory exists
describe directory('/.deluge/prep') do
  it { should be_directory }
  it { should be_owned_by 'deluge' }
  it { should be_grouped_into 'deluge' }
end

# /.deluge/staging directory exists
describe directory('/.deluge/staging') do
  it { should be_directory }
  it { should be_owned_by 'deluge' }
  it { should be_grouped_into 'deluge' }
end

# /.deluge/complete directory exists
describe directory('/.deluge/complete') do
  it { should be_directory }
  it { should be_owned_by 'deluge' }
  it { should be_grouped_into 'deluge' }
end

# /.deluge/complete/tv directory exists
describe directory('/.deluge/complete/tv') do
  it { should be_directory }
  it { should be_owned_by 'deluge' }
  it { should be_grouped_into 'deluge' }
end

# /.deluge/complete/movie directory exists
describe directory('/.deluge/complete/movie') do
  it { should be_directory }
  it { should be_owned_by 'deluge' }
  it { should be_grouped_into 'deluge' }
end

# deluged is installed
describe package('deluge-daemon') do
  it { should be_installed }
end

# deluged.service exists
describe file('/etc/systemd/system/deluged.service') do
  it { should be_file }
end

# deluge-web.service exists
describe file('/etc/systemd/system/deluge-web.service') do
  it { should be_file }
end

# deluge-web service is enabled and running
describe service('deluged') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

# deluge-console is installed
describe package('deluge-console') do
  it { should be_installed }
end

# auth file exists
describe file('/var/lib/deluge/.config/deluge/auth') do
  # load node attributes
  let(:node) { json('/tmp/kitchen/dna.json').params }

  it { should be_file }
  its('content') { should match "^localclient.*$" }

  its('content') {
    skip if node["config"]["auth"] == false
    should match "^couchserver:fakecouchpw:10$"
    should match "^sonarrserver:fakesonarrpw:10$"
  }
  its('content') {
    skip if node["config"]["auth"] == false
    should match "^sonarrserver:fakesonarrpw:10$"
  }

end