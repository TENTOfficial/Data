
const fs = require('fs');
function splitfile(filename){
  var MB = 1000000
  const splitFile = require('split-file');
  splitFile.splitFileBySize(filename, 1024 * 1024 * 1024)
    .then((names) => {
      console.log(names);
    })
    .catch((err) => {
      console.log('Error: ', err);
    });
}
fs.readdir('H:/Blockchain', (err, files) => {
  files.forEach(file => {
    splitfile('H:/Blockchain/' + file)
  });
})
