
import dataPreferences from '@ohos.data.preferences'
import Logger from '../common/utils/Logger';
import PreferencesUtil from '../common/database/PreferencesUtil';

@Entry
@Component
struct Login{
  @State userName:string = "";
  @State password:string = "";
  @State remPwd:boolean = false;




  initUserInfo(){
    PreferencesUtil.getPreferencesValueByKey('userName').then((value)=>{
      this.userName = value.toString();
    })
    PreferencesUtil.getPreferencesValueByKey('password').then((value)=>{
      this.password = value.toString();
    })
  }


  onPageShow(){
    this.initUserInfo();
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






      Button('登录').onClick(()=>{
        PreferencesUtil.savePreference('userName',this.userName);
        PreferencesUtil.savePreference('password',this.password);
      })
    }.margin(90).align(Alignment.Center);



  }

}