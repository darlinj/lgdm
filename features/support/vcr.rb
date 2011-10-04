require 'vcr'

VCR.config do |c|
  c.ignore_hosts '127.0.0.1', 'localhost'
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.stub_with :webmock # or :fakeweb
end
