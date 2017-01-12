var DateUtil = {
    format: function (o) {
        var s = "";
        if (typeof(o) == "string") {
            s = o;
        } else {
            s = o.value;
        }
        if (s.length == 4) {
            o.value = s + "-";
        }
        if (s.length == 7) {
            o.value = s + "-";
        }
        if (s.length > 10) {
            o.value = s.substring(0, 10);
        }
    },
    parse: function (str) {
        if (typeof str == 'string') {
            var results = str.match(/^ *(\d{4})-(\d{1,2})-(\d{1,2}) *$/);
            if (results && results.length > 3)
                return new Date(parseInt(results[1]), parseInt(results[2]) - 1, parseInt(results[3]));
            results = str.match(/^ *(\d{4})-(\d{1,2})-(\d{1,2}) +(\d{1,2}):(\d{1,2}):(\d{1,2}) *$/);
            if (results && results.length > 6)
                return new Date(parseInt(results[1]), parseInt(results[2]) - 1, parseInt(results[3]), parseInt(results[4]), parseInt(results[5]), parseInt(results[6]));
            results = str.match(/^ *(\d{4})-(\d{1,2})-(\d{1,2}) +(\d{1,2}):(\d{1,2}):(\d{1,2})\.(\d{1,9}) *$/);
            if (results && results.length > 7)
                return new Date(parseInt(results[1]), parseInt(results[2]) - 1, parseInt(results[3]), parseInt(results[4]), parseInt(results[5]), parseInt(results[6]), parseInt(results[7]));
        }
        return null;
    },
    addDay: function (date, days) {
        var a = new Date(date)
        a = a.valueOf()
        a = a + days * 24 * 60 * 60 * 1000
        a = new Date(a)
        return a;
    }
};
