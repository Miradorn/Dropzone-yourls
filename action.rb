require 'Httparty'
require 'Uri'
# Dropzone Action Info
# Name: ShortUrl
# Description: Shortens an url with yourls
# Handles: Text
# Creator: Alexander Schramm
# URL: http://yoursite.com
# Events: Dragged, Clicked
# KeyModifiers: Command, Option, Control, Shift
# SkipConfig: No
# RunsSandboxed: Yes
# Version: 1.0
# MinDropzoneVersion: 3.0

$yourls_url="URL to your yourls installation"
$signature="Your yourls signature"


def dragged
  long = $items[0]
  
  shorten(long)

end
 
def shorten(url)
  $dz.fail("not a valid uri") unless url =~ URI::ABS_URI

  $dz.begin("Shortening Url...")
  $dz.determinate(false)
  response = HTTParty.get("#{$yourls_url}?signature=#{$signature}&action=shorturl&url=#{url}", verify: false)
  shortened = response["result"]["shorturl"]
  $dz.finish("Shortened #{url}")
  $dz.url(shortened)

end  

def clicked
  data = $dz.read_clipboard
  shorten(data)
end
