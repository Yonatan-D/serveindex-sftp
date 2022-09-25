const express = require("express");
const serveIndex = require("serve-index");

const app = express();
const { port = 80, args } = require("minimist")(process.argv.slice(2));
const [user, pass, uid, gid, dir] = args.split(":");

let filePath = dir ? `/home/${user}/${dir}` : `/home/${user}`;

function staticDirToUrl(prefixUrl, dir) {
  // icons: 展示图标，views: 展示文件详细信息
  var index = serveIndex(dir, { icons: true, view: "details" });
  // 设置express静态目录为fixtures目录
  var serve = express.static(dir);
  // 设置查看根路径为/public, 中间件先处理设置静态文件函数， 然后再处理serveIndex函数
  app.use(prefixUrl, serve, index);
}

staticDirToUrl("/", filePath);

app.listen(port, () => {
  console.log(
    `[serverIndex](${filePath}) listening at http://localhost:${port}`
  );
});
