import dataPreferences from '@ohos.data.preferences'
import CommonConstants from '../constants/CommonConstants'
import Logger from '../utils/Logger';

const TAG = 'PREFERENCES';
export class PreferenceUtil{
  createPreference(context){
    globalThis.getPreferences = (()=>{
      let preferences: Promise<dataPreferences.Preferences> = dataPreferences.getPreferences(context, CommonConstants.PREFERENCES_NAME);
      return preferences;
    });


  }
  savePreference(key:string,value:any){
    globalThis.getPreferences().then((preferences:dataPreferences.Preferences)=>{
      preferences.has(key).then(async (isExist)=>{
        Logger.info(TAG, 'preferences has key: '+ key);
        if (!isExist){
          await preferences.put(key, value);
          preferences.flush();
        }
      }).catch((err)=>{
        Logger.error(TAG, 'has the value failed with err: '+err);
      });
    }).catch((err)=>{
      Logger.error(TAG, 'get the preferences failed,err: '+err);
    })
  }

  saveChangePreference(key:string, value:any){
    globalThis.getPreferences().then(async(preferences:dataPreferences.Preferences)=>{
      await preferences.put(key,value);
      preferences.flush();
    }).catch((err)=>{
      Logger.error(TAG, 'get the preferences failed,err: '+err);
    });
  }

  async getPreferencesValueByKey(key:string){
    const preferences:dataPreferences.Preferences = globalThis.getPreferences();
    let value = await preferences.get(key,'');
    return value;
  }

  async deletePreferencesByKey(key:string){
    const preferences:dataPreferences.Preferences = globalThis.getPreferences();
    let deletedValue = preferences.delete(key);
    deletedValue.then(()=>{
      Logger.info(TAG, 'delete success');
    }).catch((err)=>{
      Logger.error(TAG, 'delete failed');
    })
  }


}

export default new PreferenceUtil();