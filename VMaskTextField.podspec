Pod::Spec.new do |s|
  s.name             = "VMaskTextField"
  s.version          = "1.0.4"
  s.summary          = "VMaskTextField is a library which create an input mask."
  s.description      = <<-DESC
                       An inputmask helps the user with the input by ensuring a predefined format. This can be useful for dates, numerics, phone numbers etc
                       DESC
  s.homepage         = "https://github.com/viniciusmo/VMaskTextField"
  s.license          = 'MIT'
  s.author           = { "viniciusmo" => "vinicius.moises.oliveira@gmail.com" }
  s.source           = { :git => "https://github.com/viniciusmo/VMaskTextField.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/viniciusmo90'
  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
end
