
import  Logger  from '../utils/Logger';

import relationalStore from '@ohos.data.relationalStore'; // 导入模块
import CommonConstants from '../constants/CommonConstants';



export default class Rdb{
  private rdbStore:relationalStore.RdbStore = null;
  private tableName:string;
  private sqlCreateTable:string;
  private columns:Array<string>;

  constructor(tableName:string, sqlCreateTable:string, columns:Array<string> ) {
    this.tableName = tableName;
    this.sqlCreateTable = sqlCreateTable;
    this.columns = columns;
  }


  getTdbStore(callback){
    if(!callback || typeof callback == 'undefined' || callback == undefined){
      Logger.error('rdb','未获取到rdb回调');
      return;
    }

    if(this.rdbStore != null){
      Logger.error('rdb','rdb实例已存在');
      callback();
      return;
    }

    let context = getContext(this);

    relationalStore.getRdbStore(context,CommonConstants.STORE_CONFIG,(err, store)=>{
      if(err){
        Logger.error('rdb',err);
        return;
      }
      this.rdbStore = store;
      store.executeSql(this.sqlCreateTable);
      Logger.info('rdb','获取实例成功');
      callback();
    });


  }

  insertData(data,callback){
    if(!callback || typeof callback == 'undefined' || callback == undefined){
      Logger.error('rdb','未获取到rdb insert回调');
      return;
    }

    let resFlag: boolean = false;
    const valueBucket = data;

    this.rdbStore.insert(this.tableName, valueBucket,(err,rowId)=>{
      if(err){
        Logger.error('rdb', 'inset() data failed, err:'+ err);
        callback(resFlag);
        return;
      }
      Logger.info('rdb', 'insertData() finished: '+ rowId);
      callback(!resFlag);
    })

  }

  deleteData(predicates, callback){
    if(!callback || typeof callback == 'undefined' || callback == undefined){
      Logger.error('rdb','未获取到rdb delete回调');
      return;
    }
    let resFlag:boolean = false;
    this.rdbStore.delete(predicates,(err,rowId)=>{
      if(err){
        Logger.error('rdb', 'delete() data failed, err:'+ err);
        callback(resFlag);
        return;
      }
      Logger.info('rdb', 'delete rows success '+ rowId);
      callback(!resFlag);
    })

  }

  updateData(predicates,data, callback){
    if(!callback || typeof callback == 'undefined' || callback == undefined){
      Logger.error('rdb','未获取到rdb update回调');
      return;
    }
    let resFlag:boolean = false;
    const  valueBucket = data;
    this.rdbStore.update(predicates,valueBucket,(err,rowId)=>{
      if(err){
        Logger.error('rdb', 'update() data failed, err:'+ err);
        callback(resFlag);
        return;
      }
      Logger.info('rdb', 'update rows success '+ rowId);
      callback(!resFlag);
    });
  }

  query(predicates, callback){
    if(!callback || typeof callback == 'undefined' || callback == undefined){
      Logger.error('rdb','未获取到rdb query回调');
      return;
    }
    this.rdbStore.query(predicates,this.columns,(err, resultSet)=>{
      if(err){
        Logger.error('rdb', 'query() data failed, err:'+ err);
        return;
      }
      Logger.info('rdb' , 'query() data success');
      callback(resultSet);
      resultSet.close();
    })
  }
  
}