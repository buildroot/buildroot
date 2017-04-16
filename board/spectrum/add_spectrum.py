#!/usr/bin/python
import json, os, sys

if (os.getenv('TARGET_DIR')):
    webbridgePath = os.getenv('TARGET_DIR') + '/etc/webbridge/'
else:
    webbridgePath = 'output/target/etc/webbridge/'

webbridgeFile = webbridgePath + 'config.json'

spectrumObj = {
   'callsign':'Spectrum',
   'locator':'libwebkitbrowser.so',
   'classname':'WebKitBrowser',
   'autostart':True,
   'configuration':{
        'url':'file:///www/index.html',
        'useragent':'Mozilla/5.0 (Macintosh, Intel Mac OS X 10_11_4) AppleWebKit/602.1.28+ (KHTML, like Gecko) Version/9.1 Safari/601.5.17 WPE-Spectrum',
        'injectedbundle':'libWPEInjectedBundle.so',
        'transparent':True,
        'compositor':'noaa',
        'inspector':'0.0.0.0:9997',
        'fps':True,
        'cursor':False,
        'touch':False,
        'msebuffers':'audio:2m,video:15m,text:1m',
        'memoryprofile':150,
        'memorypressure':'databaseprocess:30m,networkprocess:50m,webprocess:300m,rpcprocess:50m',
        'mediadiskcache':False,
        'diskcache':'90m',
        'xhrcache':True
    }
}

print('Reading webbridge file at: ' + webbridgeFile)

with open(webbridgeFile, 'r') as f:
    data = json.load(f)


print('Successfully loaded webbridge config.json')
#print(json.dumps(data, indent=4, separators=(',',':')))

for plugin in data['plugins']:
    #print('Checking ' + plugin['callsign'])
    if (plugin['callsign'] == 'Spectrum'):
        print('Already present in config.json')
        sys.exit()

data['plugins'].insert(-1, spectrumObj)
print('Successfully inserted plugin into webbridge config.json')
#print(json.dumps(data, indent=4, separators=(',',':')))

with open(webbridgeFile, 'w') as f:
     json.dump(data, f, indent=4, separators=(',',':'))
