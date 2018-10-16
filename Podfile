# Uncomment the next line to define a global platform for your project
platform :osx, '10.12'
workspace 'Desktop.xcworkspace'
use_frameworks!

def important_pods
  pod 'RxSwift'
  pod 'RxCocoa'
end

target 'Desktop' do
    project 'Desktop.xcodeproj'
   important_pods

  target 'DesktopTests' do
    inherit! :search_paths
    important_pods
  end

end

target 'DesktopCore' do
   project 'DesktopCore/DesktopCore.xcodeproj'
   important_pods
   
   target 'DesktopCoreTests' do
       inherit! :search_paths
       important_pods
   end
end
