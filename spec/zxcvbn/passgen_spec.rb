require 'zxcvbn'

RSpec.describe Zxcvbn::Passgen do
  it "has a version number" do
    expect(Zxcvbn::Passgen::VERSION).not_to be nil
  end

  it "generated 4 score password" do
    expect(Zxcvbn.test(Zxcvbn::Passgen.generate).score == 4).to eq(true)
  end

  it "generated less than 4 score password" do
    expect(Zxcvbn.test(Zxcvbn::Passgen.make(10)).score < 4).to eq(true)
  end

  it "raise error when password length less than 11" do
    begin
      Zxcvbn.test(Zxcvbn::Passgen.generate(10))
    rescue => exception
      error = exception.to_s
    end
    expect(error).to eq("Password length must be greater or equal 11.")
  end
end
