interface IUserWizardStep {
  type:string;
  label?:Function;
  summaryLabel?:string;
  bindLabel?:string;
  formControlName?:string;
  apiCallback?:Function;
  description?:Function;
  rightButtonText?:string;
  leftButtonText?:string;
  showInviteUserByEmail?:boolean;
  action?:Function;
}

interface IUserWizardSelectData {
  name:string;
  id:string;
  email:string;
  disabled:boolean;
  _type?:string;
}