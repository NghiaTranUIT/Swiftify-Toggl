# Uncomment the next line to define a global platform for your project
platform :osx, '10.12'
workspace 'Desktop.xcworkspace'

def important_pods
  pod 'RxSwift'
  pod 'RxCocoa'
end

target 'Desktop' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Desktop
  important_pods

  target 'DesktopTests' do
    inherit! :search_paths
    # Pods for testing
  end

end

target 'DesktopCore' do
   project 'DesktopCore/DesktopCore.xcodeproj'

   important_pods 
end
