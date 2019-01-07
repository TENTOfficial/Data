const splitFile = require('split-file');
var filenName = [
  '~/bc.sf-part1',
  '~/bc.sf-part2',
  '~/bc.sf-part3',
  '~/bc.sf-part4'
]
splitFile.mergeFiles(filenName, '~/blockchain.zip')
.then(function(){
  console.log("Join blockchain success")
})
.catch(function(err){
  console.log('Error: ', err);
});
