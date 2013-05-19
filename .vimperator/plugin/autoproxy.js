// only set string value
function setPreferenceValue(branch, name, value) {
    var prefs = Components.classes["@mozilla.org/preferences-service;1"].getService(Components.interfaces.nsIPrefService).getBranch(branch);
    var str = Components.classes["@mozilla.org/supports-string;1"].createInstance(Components.interfaces.nsISupportsString);
    str.data = value;
    prefs.setComplexValue(name, Components.interfaces.nsISupportsString, str);
}
function getPreferenceValue(branch, name) {
    var prefs = Components.classes["@mozilla.org/preferences-service;1"].getService(Components.interfaces.nsIPrefService).getBranch(branch);
    if (prefs.prefHasUserValue(name)) {
        return prefs.getComplexValue(name, Components.interfaces.nsISupportsString).data;
    } else {
        return null;
    }
}
commands.addUserCommand (["autoproxy", "ap"], "change autoproxy status",
    function (args) {
        if (args.length == 0) { // print current autoproxy status
            var mode = getPreferenceValue("extensions.autoproxy.", "proxyMode");
            liberator.echo("proxyMode is " + mode);
        } else {
            var arg = args[0].toLowerCase();
            var mode;
            if (arg.indexOf('d') == 0) {
                mode = 'disabled';
            } else if (arg.indexOf('a') == 0) {
                mode = 'auto';
            } else if (arg.indexOf('g') == 0) {
                mode = 'global';
            } else {
                liberator.echoerr("mode should be one of 'disabled', 'auto' or 'global'");
            }
            setPreferenceValue("extensions.autoproxy.", "proxyMode", mode);
            liberator.echo("set proxyMode to " + mode);
        }
    }, {
        argCount: "?",
    }
);
