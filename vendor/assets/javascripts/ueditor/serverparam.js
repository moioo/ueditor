UE.plugin.register('serverparam', function() {
  var me = this,
    serverParam = {},
    utils = UE.utils;
  return {
    commands: {
      'serverparam': {
        execCommand: function(cmd, key, value) {
          if (key === undefined || key === null) { //不传参数,清空列表
            serverParam = {};
          } else if (utils.isString(key)) { //传入键值
            if (value === undefined || value === null) {
              delete serverParam[key];
            } else {
              serverParam[key] = value;
            }
          } else if (utils.isObject(key)) { //传入对象,覆盖列表项
            utils.extend(serverParam, key, true);
          } else if (utils.isFunction(key)) { //传入函数,添加列表项
            utils.extend(serverParam, key(), true);
          }
        },
        queryCommandValue: function() {
          var defaultParam =  utils.isObject(me.options.defaultParam) ? me.options.defaultParam : {};
          return utils.extend((serverParam || {}), defaultParam);
        }
      }
    }
  }
});
