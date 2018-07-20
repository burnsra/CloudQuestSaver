(function() {
    var Saver;

    Saver = (function() {
        function Saver() {}

        Saver.prototype.itemSize = 48;

        Saver.prototype.boxes = [];

        Saver.prototype.icons = [];

        Saver.prototype.start = function() {
            this.container = document.querySelector('#screen');
            this.logoIcon = false;
            this.setIcons();
            this.setSize();
            this.drawBoxes();
            return setInterval(this.flashIcon, 100);
        };

        Saver.prototype.setIcons = function() {
            var _icons = ["cloudquest","kubernetes-logo","forseti-logo","advanced-solutions-lab","cloud-load-balancing","data-loss-prevention-api","app-engine","cloud-machine-learning","data-studio","beyondcorp","cloud-natural-language-api","data-transfer-appliance","bigquery","cloud-network","debugger","cloud-apis","cloud-partner-interconnect","error-reporting","cloud-bigtable","cloud-pubsub","generic-gcp","cloud-cdn","cloud-router","genomics","cloud-dataflow","cloud-routes","cloud-datalab","cloud-spanner","cloud-dataprep","cloud-speech-api","cloud-dataproc","cloud-sql","google-plugin-for-eclipse","cloud-datastore","cloud-storage","gpu","cloud-deployment-manager","cloud-tools-for-visual-studio","identity-aware-proxy","cloud-dns","cloud-translation-api","key-management-service","cloud-endpoints","cloud-video-intelligence-api","logging","cloud-external-ip-addresses","cloud-vision-api","monitoring","cloud-firewall-rules","cloud-vpn","persistent-disk","cloud-functions","compute-engine","prediction-api","cloud-iam","container-builder","security-key-enforcement","cloud-interconnect","container-engine","stackdriver","cloud-iot-core","container-optimized-os","trace","cloud-jobs-api","container-registry","virtual-private-cloud"];
            this.icons = _icons;
            if( $.inArray('cloudquest', this.icons) != -1) {
                this.logoIcon = true;
                this.icons.splice(this.icons.indexOf('cloudquest'), 1);
            }
        }

        Saver.prototype.setSize = function() {
            var left, top;
            this.screenWidth = document.body.getBoundingClientRect().width;
            this.screenHeight = document.body.getBoundingClientRect().height;
            this.cols = Math.ceil(this.screenWidth / this.itemSize);
            if (this.cols % 2 === 1) {
                this.cols += 1;
            }
            this.rows = Math.ceil(this.screenHeight / this.itemSize);
            if (this.rows % 2 === 0) {
                this.rows += 1;
            }
            this.width = this.cols * this.itemSize;
            this.height = this.rows * this.itemSize;
            left = -(this.width - this.screenWidth) / 2;
            top = -(this.height - this.screenHeight) / 2;
            this.container.style.width = this.width;
            this.container.style.height = this.height;
            this.container.style.top = top;
            return this.container.style.left = left;
        };

        Saver.prototype.drawBoxes = function() {
            var box, col, row, _i, _ref, _results, _icon_current, _icon_previous;
            _results = [];
            _icon_current = 1;
            _icon_previous = 1;
            for (row = _i = 1, _ref = this.rows; 1 <= _ref ? _i <= _ref : _i >= _ref; row = 1 <= _ref ? ++_i : --_i) {
                _results.push((function() {
                    var _j, _ref1, _results1;
                    _results1 = [];
                    for (col = _j = 1, _ref1 = this.cols; 1 <= _ref1 ? _j <= _ref1 : _j >= _ref1; col = 1 <= _ref1 ? ++_j : --_j) {
                        box = document.createElement('div');
                        box.classList.add('octicon-mega');
                        if (this.logoIcon && row === Math.ceil(this.rows / 2) && (col === (this.cols / 2) - 2 || col === (this.cols / 2) - 1 || col === (this.cols / 2) || col === (this.cols / 2) + 1)) {
                            if (col == (this.cols / 2) - 2) {
                                box.classList.add('logo');
                                box.classList.add('icon-cloudquest');
                            } else {
                                box.classList.add('icon');
                            }
                        } else {
                            do {
                               _icon_current = Math.floor(Math.random() * this.icons.length);
                            }
                            while (_icon_current == _icon_previous);
                            _icon_previous = _icon_current;
                            box.classList.add('icon');
                            box.classList.add('icon-' + this.icons[_icon_current]);
                        }
                        _results1.push(this.container.appendChild(box));
                    }
                    return _results1;
                }).call(this));
            }
            return _results;
        };

        Saver.prototype.flashIcon = function() {
            var box, boxes, clear;
            boxes = document.querySelectorAll('.icon:not(.fading)');
            box = boxes[Math.floor(Math.random() * boxes.length)];
            box.classList.add('fading');
            clear = function() {
                return box.classList.remove('fading');
            };
            return setTimeout(clear, 8000);
        };

        return Saver;

    })();

    new Saver().start();

}).call(this);

var getUrlParams = function(prop) {
    var params = {};
    var search = decodeURIComponent(window.location.href.slice(window.location.href.indexOf('?') + 1));
    var definitions = search.split('&');

    definitions.forEach(function(val, key) {
        var parts = val.split('=',2);
        params[parts[0]] = parts[1];
    });
    return (prop && prop in params) ? params[prop] : params;
}

$().ready(function() {
    console.log(getUrlParams("animate"));
    if (!getUrlParams("animate")) {
        $("body").addClass("animated-background")
    }
});
