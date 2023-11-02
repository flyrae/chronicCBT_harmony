import relationalStore from '@ohos.data.relationalStore'
export default class CommonConstants {
  static readonly STORE_CONFIG = {
    name: 'liveBetter.db',
    securityLevel: relationalStore.SecurityLevel.S1
  }

  static readonly  PREFERENCES_NAME = 'livePreferences';

}