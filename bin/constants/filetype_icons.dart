part of '../dexa.dart';

// default icons in case nothing can be found
Map<String, String> defaultIcons = {
  "dir": "\uf74a",
  "diropen": "\ufc6e",
  "hiddendir": "\uf755",
  "exe": "\uf713",
  "file": "\uf723",
  "hiddenfile": "\ufb12",
};

// RGB to ansi format: \x1b[38;2;<r>;<g>;<b>m
Map<String, Map<String, String>> iconSet = {
  "symlink": {"icon": "\uf1177", "color": "\x1b[38;2;228;79;57m"}, // symlink
  "html": {"icon": "\uf13b", "color": "\x1b[38;2;228;79;57m"}, // html
  "markdown": {"icon": "\uf853", "color": "\x1b[38;2;66;165;245m"}, // markdown
  "md": {"icon": "\uf853", "color": "\x1b[38;2;66;165;245m"}, // markdown
  "css": {"icon": "\uf81b", "color": "\x1b[38;2;66;165;245m"}, // css
  "sass": {"icon": "\ue603", "color": "\x1b[38;2;237;80;122m"}, // sass
  "less": {"icon": "\ue60b", "color": "\x1b[38;2;2;119;189m"}, // less
  "json": {"icon": "\ue60b", "color": "\x1b[38;2;251;193;60m"}, // json
  "yaml": {"icon": "\ue60b", "color": "\x1b[38;2;244;68;62m"}, // yaml
  "xml": {"icon": "\uf72d", "color": "\x1b[38;2;64;153;69m"}, // xml
  "image": {"icon": "\uf71e", "color": "\x1b[38;2;48;166;154m"}, // image
  "javascript": {
    "icon": "\ue74e",
    "color": "\x1b[38;2;255;202;61m"
  }, // javascript
  "js": {"icon": "\ue74e", "color": "\x1b[38;2;255;202;61m"}, // javascript
  "react": {"icon": "\ue7ba", "color": "\x1b[38;2;35;188;212m"}, // react
  "react_ts": {"icon": "\ue7ba", "color": "\x1b[38;2;36;142;211m"}, // react_ts
  "settings": {"icon": "\uf013", "color": "\x1b[38;2;66;165;245m"}, // settings
  "typescript": {
    "icon": "\ue628",
    "color": "\x1b[38;2;3;136;209m"
  }, // typescript
  "pdf": {"icon": "\uf724", "color": "\x1b[38;2;244;68;62m"}, // pdf
  "table": {"icon": "\uf71a", "color": "\x1b[38;2;139;195;74m"}, // table
  "visualstudio": {
    "icon": "\ue70c",
    "color": "\x1b[38;2;173;99;188m"
  }, // visualstudio
  "database": {"icon": "\ue706", "color": "\x1b[38;2;255;202;61m"}, // database
  "mysql": {"icon": "\ue704", "color": "\x1b[38;2;1;94;134m"}, // mysql
  "postgresql": {
    "icon": "\ue76e",
    "color": "\x1b[38;2;49;99;140m"
  }, // postgresql
  "sqlite": {"icon": "\ue7c4", "color": "\x1b[38;2;1;57;84m"}, // sqlite
  "csharp": {"icon": "\uf81a", "color": "\x1b[38;2;2;119;189m"}, // csharp
  "zip": {"icon": "\uf410", "color": "\x1b[38;2;175;180;43m"}, // zip
  "exe": {"icon": "\uf2d0", "color": "\x1b[38;2;229;77;58m"}, // exe
  "java": {"icon": "\uf675", "color": "\x1b[38;2;244;68;62m"}, // java
  "c": {"icon": "\ufb70", "color": "\x1b[38;2;2;119;189m"}, // c
  "cpp": {"icon": "\ufb71", "color": "\x1b[38;2;2;119;189m"}, // cpp
  "go": {"icon": "\ufcd1", "color": "\x1b[38;2;32;173;194m"}, // go
  "go-mod": {"icon": "\ufcd1", "color": "\x1b[38;2;237;80;122m"}, // go-mod
  "python": {"icon": "\uf81f", "color": "\x1b[38;2;52;102;143m"}, // python
  "python-misc": {
    "icon": "\uf820",
    "color": "\x1b[38;2;130;61;28m"
  }, // python-misc
  "url": {"icon": "\uf836", "color": "\x1b[38;2;66;165;245m"}, // url
  "console": {"icon": "\uf68c", "color": "\x1b[38;2;250;111;66m"}, // console
  "word": {"icon": "\uf72b", "color": "\x1b[38;2;1;87;155m"}, // word
  "certificate": {
    "icon": "\uf623",
    "color": "\x1b[38;2;249;89;63m"
  }, // certificate
  "key": {"icon": "\uf805", "color": "\x1b[38;2;48;166;154m"}, // key
  "font": {"icon": "\uf031", "color": "\x1b[38;2;244;68;62m"}, // font
  "lib": {"icon": "\uf831", "color": "\x1b[38;2;139;195;74m"}, // lib
  "ruby": {"icon": "\ue739", "color": "\x1b[38;2;229;61;58m"}, // ruby
  "gemfile": {"icon": "\ue21e", "color": "\x1b[38;2;229;61;58m"}, // gemfile
  "fsharp": {"icon": "\ue7a7", "color": "\x1b[38;2;55;139;186m"}, // fsharp
  "swift": {"icon": "\ufbe3", "color": "\x1b[38;2;249;95;63m"}, // swift
  "docker": {"icon": "\uf308", "color": "\x1b[38;2;1;135;201m"}, // docker
  "powerpoint": {
    "icon": "\uf726",
    "color": "\x1b[38;2;209;71;51m"
  }, // powerpoint
  "video": {"icon": "\uf72a", "color": "\x1b[38;2;253;154;62m"}, // video
  "virtual": {"icon": "\uf822", "color": "\x1b[38;2;3;155;229m"}, // virtual
  "email": {"icon": "\uf6ed", "color": "\x1b[38;2;66;165;245m"}, // email
  "audio": {"icon": "\ufb75", "color": "\x1b[38;2;239;83;80m"}, // audio
  "coffee": {"icon": "\uf675", "color": "\x1b[38;2;66;165;245m"}, // coffee
  "document": {"icon": "\uf718", "color": "\x1b[38;2;66;165;245m"}, // document
  "rust": {"icon": "\ue7a8", "color": "\x1b[38;2;250;111;66m"}, // rust
  "raml": {"icon": "\ue60b", "color": "\x1b[38;2;66;165;245m"}, // raml
  "xaml": {"icon": "\ufb72", "color": "\x1b[38;2;66;165;245m"}, // xaml
  "haskell": {"icon": "\ue61f", "color": "\x1b[38;2;254;168;62m"}, // haskell
  "git": {"icon": "\ue702", "color": "\x1b[38;2;229;77;58m"}, // git
  "gitignore": {"icon": "\ue702", "color": "\x1b[38;2;229;77;58m"}, // git
  "lua": {"icon": "\ue620", "color": "\x1b[38;2;66;165;245m"}, // lua
  "clojure": {"icon": "\ue76a", "color": "\x1b[38;2;100;221;23m"}, // clojure
  "groovy": {"icon": "\uf2a6", "color": "\x1b[38;2;41;198;218m"}, // groovy
  "r": {"icon": "\ufcd2", "color": "\x1b[38;2;25;118;210m"}, // r
  "dart": {"icon": "\ue798", "color": "\x1b[38;2;87;182;240m"}, // dart
  "mxml": {"icon": "\uf72d", "color": "\x1b[38;2;254;168;62m"}, // mxml
  "assembly": {"icon": "\uf471", "color": "\x1b[38;2;250;109;63m"}, // assembly
  "vue": {"icon": "\ufd42", "color": "\x1b[38;2;65;184;131m"}, // vue
  "vue-config": {
    "icon": "\ufd42",
    "color": "\x1b[38;2;58;121;110m"
  }, // vue-config
  "lock": {"icon": "\uf83d", "color": "\x1b[38;2;255;213;79m"}, // lock
  "handlebars": {
    "icon": "\ue60f",
    "color": "\x1b[38;2;250;111;66m"
  }, // handlebars
  "perl": {"icon": "\ue769", "color": "\x1b[38;2;149;117;205m"}, // perl
  "elixir": {"icon": "\ue62d", "color": "\x1b[38;2;149;117;205m"}, // elixir
  "erlang": {"icon": "\ue7b1", "color": "\x1b[38;2;244;68;62m"}, // erlang
  "twig": {"icon": "\ue61c", "color": "\x1b[38;2;155;185;47m"}, // twig
  "julia": {"icon": "\ue624", "color": "\x1b[38;2;134;82;159m"}, // julia
  "elm": {"icon": "\ue62c", "color": "\x1b[38;2;96;181;204m"}, // elm
  "smarty": {"icon": "\uf834", "color": "\x1b[38;2;255;207;60m"}, // smarty
  "stylus": {"icon": "\ue600", "color": "\x1b[38;2;192;202;51m"}, // stylus
  "verilog": {"icon": "\ufb19", "color": "\x1b[38;2;250;111;66m"}, // verilog
  "robot": {"icon": "\ufba7", "color": "\x1b[38;2;249;89;63m"}, // robot
  "solidity": {"icon": "\ufcb9", "color": "\x1b[38;2;3;136;209m"}, // solidity
  "yang": {"icon": "\ufb7e", "color": "\x1b[38;2;66;165;245m"}, // yang
  "vercel": {"icon": "\uf47e", "color": "\x1b[38;2;207;216;220m"}, // vercel
  "applescript": {
    "icon": "\uf302",
    "color": "\x1b[38;2;120;144;156m"
  }, // applescript
  "cake": {"icon": "\uf5ea", "color": "\x1b[38;2;250;111;66m"}, // cake
  "nim": {"icon": "\uf6a4", "color": "\x1b[38;2;255;202;61m"}, // nim
  "todo": {"icon": "\uf058", "color": "\x1b[38;2;124;179;66m"}, // todo
  "nix": {"icon": "\uf313", "color": "\x1b[38;2;80;117;193m"}, // nix
  "http": {"icon": "\uf484", "color": "\x1b[38;2;66;165;245m"}, // http
  "webpack": {"icon": "\ufc29", "color": "\x1b[38;2;142;214;251m"}, // webpack
  "ionic": {"icon": "\ue7a9", "color": "\x1b[38;2;79;143;247m"}, // ionic
  "gulp": {"icon": "\ue763", "color": "\x1b[38;2;229;61;58m"}, // gulp
  "nodejs": {"icon": "\uf898", "color": "\x1b[38;2;139;195;74m"}, // nodejs
  "npm": {"icon": "\ue71e", "color": "\x1b[38;2;203;56;55m"}, // npm
  "yarn": {"icon": "\uf61a", "color": "\x1b[38;2;44;142;187m"}, // yarn
  "android": {"icon": "\uf531", "color": "\x1b[38;2;139;195;74m"}, // android
  "tune": {"icon": "\ufb69", "color": "\x1b[38;2;251;193;60m"}, // tune
  "contributing": {
    "icon": "\uf64d",
    "color": "\x1b[38;2;255;202;61m"
  }, // contributing
  "readme": {"icon": "\uf7fb", "color": "\x1b[38;2;66;165;245m"}, // readme
  "changelog": {
    "icon": "\ufba6",
    "color": "\x1b[38;2;139;195;74m"
  }, // changelog
  "credits": {"icon": "\uf75f", "color": "\x1b[38;2;156;204;101m"}, // credits
  "authors": {"icon": "\uf0c0", "color": "\x1b[38;2;244;68;62m"}, // authors
  "favicon": {"icon": "\ue623", "color": "\x1b[38;2;255;213;79m"}, // favicon
  "karma": {"icon": "\ue622", "color": "\x1b[38;2;60;190;174m"}, // karma
  "travis": {"icon": "\ue77e", "color": "\x1b[38;2;203;58;73m"}, // travis
  "heroku": {"icon": "\ue607", "color": "\x1b[38;2;105;99;185m"}, // heroku
  "gitlab": {"icon": "\uf296", "color": "\x1b[38;2;226;69;57m"}, // gitlab
  "bower": {"icon": "\ue61a", "color": "\x1b[38;2;239;88;60m"}, // bower
  "conduct": {"icon": "\uf64b", "color": "\x1b[38;2;205;220;57m"}, // conduct
  "jenkins": {"icon": "\ue767", "color": "\x1b[38;2;240;214;183m"}, // jenkins
  "code-climate": {
    "icon": "\uf7f4",
    "color": "\x1b[38;2;238;238;238m"
  }, // code-climate
  "log": {"icon": "\uf719", "color": "\x1b[38;2;175;180;43m"}, // log
  "ejs": {"icon": "\ue618", "color": "\x1b[38;2;255;202;61m"}, // ejs
  "grunt": {"icon": "\ue611", "color": "\x1b[38;2;251;170;61m"}, // grunt
  "django": {"icon": "\ue71d", "color": "\x1b[38;2;67;160;71m"}, // django
  "makefile": {"icon": "\uf728", "color": "\x1b[38;2;239;83;80m"}, // makefile
  "bitbucket": {
    "icon": "\uf171",
    "color": "\x1b[38;2;31;136;229m"
  }, // bitbucket
  "d": {"icon": "\ue7af", "color": "\x1b[38;2;244;68;62m"}, // d
  "mdx": {"icon": "\uf853", "color": "\x1b[38;2;255;202;61m"}, // mdx
  "azure-pipelines": {
    "icon": "\uf427",
    "color": "\x1b[38;2;20;101;192m"
  }, // azure-pipelines
  "azure": {"icon": "\ufd03", "color": "\x1b[38;2;31;136;229m"}, // azure
  "razor": {"icon": "\uf564", "color": "\x1b[38;2;66;165;245m"}, // razor
  "asciidoc": {"icon": "\uf718", "color": "\x1b[38;2;244;68;62m"}, // asciidoc
  "edge": {"icon": "\uf564", "color": "\x1b[38;2;239;111;60m"}, // edge
  "scheme": {"icon": "\ufb26", "color": "\x1b[38;2;244;68;62m"}, // scheme
  "3d": {"icon": "\ue79b", "color": "\x1b[38;2;40;182;246m"}, // 3d
  "svg": {"icon": "\ufc1f", "color": "\x1b[38;2;255;181;62m"}, // svg
  "vim": {"icon": "\ue62b", "color": "\x1b[38;2;67;160;71m"}, // vim
  "moonscript": {
    "icon": "\uf186",
    "color": "\x1b[38;2;251;193;60m"
  }, // moonscript
  "codeowners": {
    "icon": "\uf507",
    "color": "\x1b[38;2;175;180;43m"
  }, // codeowners
  "disc": {"icon": "\ue271", "color": "\x1b[38;2;176;190;197m"}, // disc
  "tcl": {"icon": "\ufbd1", "color": "\x1b[38;2;239;83;80m"}, // tcl
  "liquid": {"icon": "\ue275", "color": "\x1b[38;2;40;182;246m"}, // liquid
  "prolog": {"icon": "\ue7a1", "color": "\x1b[38;2;239;83;80m"}, // prolog
  "husky": {"icon": "\uf8e8", "color": "\x1b[38;2;229;229;229m"}, // husky
  "coconut": {"icon": "\uf5d2", "color": "\x1b[38;2;141;110;99m"}, // coconut
  "sketch": {"icon": "\uf6c7", "color": "\x1b[38;2;255;194;61m"}, // sketch
  "pawn": {"icon": "\ue261", "color": "\x1b[38;2;239;111;60m"}, // pawn
  "commitlint": {
    "icon": "\ufc16",
    "color": "\x1b[38;2;43;150;137m"
  }, // commitlint
  "dhall": {"icon": "\uf448", "color": "\x1b[38;2;120;144;156m"}, // dhall
  "dune": {"icon": "\uf7f4", "color": "\x1b[38;2;244;127;61m"}, // dune
  "shaderlab": {
    "icon": "\ufbad",
    "color": "\x1b[38;2;25;118;210m"
  }, // shaderlab
  "command": {"icon": "\ufb32", "color": "\x1b[38;2;175;188;194m"}, // command
  "stryker": {"icon": "\uf05b", "color": "\x1b[38;2;239;83;80m"}, // stryker
  "modernizr": {"icon": "\ue720", "color": "\x1b[38;2;234;72;99m"}, // modernizr
  "roadmap": {"icon": "\ufb6d", "color": "\x1b[38;2;48;166;154m"}, // roadmap
  "debian": {"icon": "\uf306", "color": "\x1b[38;2;211;61;76m"}, // debian
  "ubuntu": {"icon": "\uf31c", "color": "\x1b[38;2;214;73;53m"}, // ubuntu
  "arch": {"icon": "\uf303", "color": "\x1b[38;2;33;142;202m"}, // arch
  "redhat": {"icon": "\uf316", "color": "\x1b[38;2;231;61;58m"}, // redhat
  "gentoo": {"icon": "\uf30d", "color": "\x1b[38;2;148;141;211m"}, // gentoo
  "linux": {"icon": "\ue712", "color": "\x1b[38;2;238;207;55m"}, // linux
  "raspberry-pi": {
    "icon": "\uf315",
    "color": "\x1b[38;2;208;60;76m"
  }, // raspberry-pi
  "manjaro": {"icon": "\uf312", "color": "\x1b[38;2;73;185;90m"}, // manjaro
  "opensuse": {"icon": "\uf314", "color": "\x1b[38;2;111;180;36m"}, // opensuse
  "fedora": {"icon": "\uf30a", "color": "\x1b[38;2;52;103;172m"}, // fedora
  "freebsd": {"icon": "\uf30c", "color": "\x1b[38;2;175;44;42m"}, // freebsd
  "centOS": {"icon": "\uf304", "color": "\x1b[38;2;157;83;135m"}, // centOS
  "alpine": {"icon": "\uf300", "color": "\x1b[38;2;14;87;123m"}, // alpine
  "mint": {"icon": "\uf30f", "color": "\x1b[38;2;125;190;58m"}, // mint
};
