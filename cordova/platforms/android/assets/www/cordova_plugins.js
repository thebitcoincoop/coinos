cordova.define('cordova/plugin_list', function(require, exports, module) {
module.exports = [
  {
    "id": "cordova-plugin-hce.hce",
    "file": "plugins/cordova-plugin-hce/www/hce.js",
    "pluginId": "cordova-plugin-hce",
    "clobbers": [
      "hce"
    ]
  },
  {
    "id": "cordova-plugin-hce.hce.util",
    "file": "plugins/cordova-plugin-hce/www/hce-util.js",
    "pluginId": "cordova-plugin-hce",
    "clobbers": [
      "hce.util"
    ]
  }
];
module.exports.metadata = 
// TOP OF METADATA
{
  "cordova-plugin-whitelist": "1.3.3",
  "cordova-plugin-hce": "1.0.0"
};
// BOTTOM OF METADATA
});