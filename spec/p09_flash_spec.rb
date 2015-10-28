require 'rspec'
require_relative "../lib/phase6/controller_base.rb"

describe "flash" do
  let(:req) { WEBrick::HTTPRequest.new(Logger: nil) }
  let(:res) { WEBrick::HTTPResponse.new(HTTPVersion: '1.0') }
  let(:fl) { WEBrick::Cookie.new('_rla_flash', { xyz: 'abc' }.to_json) }

  before(:each) do
    flash = Flash.new(req)
    allow(req).to receive(:cookies).and_return({})
  end



  it "stores data in a cookie" do
    flash[:test]= "test_value"
    flash.store_flash(res)
    expect(res.cookies)to

  it "makes the data availible on the next visit"


end
