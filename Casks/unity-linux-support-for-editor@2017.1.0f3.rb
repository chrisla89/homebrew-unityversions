cask 'unity-linux-support-for-editor@2017.1.0f3' do
  version '2017.1.0f3,472613c02cf7'
  sha256 '21b7304b4f47f75a41bcbef685f48ab6f28b0c89b7a8d1e499fe69b6ab766178'

  url "http://netstorage.unity3d.com/unity/#{version.after_comma}/MacEditorTargetInstaller/UnitySetup-Linux-Support-for-Editor-#{version.before_comma}.pkg"
  name 'Unity Linux Build Support'
  homepage 'https://unity3d.com/unity/'

  depends_on cask: 'unity@2017.1.0f3'

  pkg "UnitySetup-Linux-Support-for-Editor-#{version.before_comma}.pkg"

  preflight do
    if File.exist? '/Applications/Unity'
      FileUtils.move '/Applications/Unity', '/Applications/Unity.temp'
    end

    if File.exist? "/Applications/Unity-#{@cask.version.before_comma}"
      FileUtils.move "/Applications/Unity-#{@cask.version.before_comma}", '/Applications/Unity'
    end
  end

  postflight do
    if File.exist? '/Applications/Unity'
      FileUtils.move '/Applications/Unity', "/Applications/Unity-#{@cask.version.before_comma}"
    end

    if File.exist? '/Applications/Unity.temp'
      FileUtils.move '/Applications/Unity.temp', '/Applications/Unity'
    end
  end

  uninstall_preflight do
    if File.exist? '/Applications/Unity'
      FileUtils.move '/Applications/Unity', '/Applications/Unity.temp'
    end

    if File.exist? "/Applications/Unity-#{@cask.version.before_comma}"
      FileUtils.move "/Applications/Unity-#{@cask.version.before_comma}", '/Applications/Unity'
    end
  end

  uninstall_postflight do
    if File.exist? '/Applications/Unity'
      FileUtils.move '/Applications/Unity', "/Applications/Unity-#{@cask.version.before_comma}"
    end

    if File.exist? '/Applications/Unity.temp'
      FileUtils.move '/Applications/Unity.temp', '/Applications/Unity'
    end
  end

  uninstall pkgutil: 'com.unity3d.LinuxStandaloneSupport'
end
