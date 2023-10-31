import preferences from '@ohos.data.preferences';
import dataPreferences from '@ohos.data.preferences'
import Logger from '../common/utils/Logger';

@Entry
@Component
struct Login{
  @State userName:string = "";
  @State password:string = "";
  @State remPwd:boolean = false;
  public  preferences:dataPreferences.Preferences = null;

  async getPreference() {
    try {
      dataPreferences.getPreferences(getContext(this), 'mystore', (err, preferences) => {
        if (err) {
          console.error(`Failed to get preferences. Code:${err.code},message:${err.message}`);
          return;
        }
        console.info('Succeeded in getting preferences.');
        // 请确保获取到Preferences实例后，再进行相关数据操作
        this.preferences = preferences;
        this.preferences.has('userName',(err,value)=>{
          if (err){

          }
          if (value){
            this.preferences.get('userName','',(err,value)=>{
              if(err){

              }
              this.userName = String(value);
            })
          }
        })
        this.preferences.has('password',(err,value)=>{
          if (err){

          }
          if (value){
            this.preferences.get('password','',(err,value)=>{
              if(err){

              }
              this.password = String(value);
            })
          }
        })
      })
    }catch (err) {
      Logger.error('info', `Failed to get preferences, Cause: ${err}`);
    }
  }


  savePwd(){
    try {
      if (this.preferences === null) {

      } else {
        console.info("The key 'startup' does not contain.");
        // 此处以此键值对不存在时写入数据为例
        this.preferences.put('username', this.userName);
        this.preferences.put('password', this.password);
      }
    } catch (err) {
      console.error(`Failed to check the key 'startup'. Code:${err.code}, message:${err.message}`);
    }
  }




  build(){
    // async this.getPreference();
    // this.getPreference();

    Column({space:20}){
      Row({space:10}){
        Text('用户名').width('50')
        TextInput({text:this.userName}).onChange((value)=>{
          this.userName = value
        })
      }

      Row({space:10}){
        Text('密码').width('50')
        TextInput({text:this.password}).onChange((value)=>{
          this.password = value
        })
      }

      Row({space:10}){
        Toggle({ type: ToggleType.Checkbox, isOn: false })
          .onChange((isOn)=>{
          this.remPwd = isOn;
        })
        Text('记住密码')
      }




      Button('getDate').onClick(()=>{
        this.getPreference();
      })

      Button('登录').onClick(()=>{
        this.savePwd();
        try {
          this.preferences.flush((err) => {
            if (err) {
              console.error(`Failed to flush. Code:${err.code}, message:${err.message}`);
              return;
            }
            console.info('Succeeded in flushing.');
          })
        } catch (err) {
          console.error(`Failed to flush. Code:${err.code}, message:${err.message}`);
        }
      })
    }.margin(90).align(Alignment.Center)

  }

}