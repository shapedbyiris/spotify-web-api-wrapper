##
##  SpotifyWebAPI.podspec
##  IRIS
##
##  Created by Ariel Elkin on 25/07/2019.
##  Copyright © 2018 IRIS. All rights reserved.
##

Pod::Spec.new do |spec|
  spec.name         = "SpotifyWebAPI"
  spec.version      = "0.5.4"
  spec.summary      = "Wrapping the Spotify Web API"
  spec.homepage     = "https://github.com/shapedbyiris/spotify-web-api-wrapper"
  spec.source = { :git => 'https://github.com/shapedbyiris/spotify-web-api-wrapper.git', :tag => spec.version }
  spec.license      = {
    :type => 'Custom',
    :text => 'Permission is hereby granted ...'
  }
  spec.author       = { "Ariel Elkin" => "ariel@shapedbyiris.com" }
  spec.platform     = :ios, :macos
  spec.ios.deployment_target = "10.0"
  spec.osx.deployment_target = "10.10"
  spec.swift_version = '5.0'
  spec.source_files  = "Sources/*.swift"

  spec.test_spec 'Tests' do |test_spec|
    test_spec.source_files = "Tests/*.swift"
    test_spec.resource_bundle = { "SpotifyWebAPIJSONMocks" => "Tests/JSONMocks/*" }
  end
end
