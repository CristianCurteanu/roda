require File.expand_path("spec_helper", File.dirname(File.dirname(__FILE__)))

describe "path_matchers plugin" do 
  it ":extension matcher should match given file extension" do
    app(:path_matchers) do |r|
      r.on "css" do
        r.on :extension=>"css" do |file|
          file
        end
      end
    end

    body("/css/reset.css").should == 'reset'
    status("/css/reset.bar").should == 404
  end

  it ":suffix matcher should match given suffix" do
    app(:path_matchers) do |r|
      r.on "css" do
        r.on :suffix=>".css" do |file|
          file
        end
      end
    end

    body("/css/reset.css").should == 'reset'
    status("/css/reset.bar").should == 404
  end

  it ":prefix matcher should match given prefix" do
    app(:path_matchers) do |r|
      r.on "css" do
        r.on :prefix=>"reset" do |file|
          file
        end
      end
    end

    body("/css/reset.css").should == '.css'
    status("/css/foo.bar").should == 404
  end
end
