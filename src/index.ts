import { NativeModules } from 'react-native';

const LINKING_ERROR = `The package '@vrgente/signature' doesn't seem to be linked.\n`;

const RNAddImageToPDF =
  NativeModules.RNAddImageToPDF ??
  new Proxy(
    {},
    {
      get() {
        throw new Error(LINKING_ERROR);
      },
    }
  );

export default RNAddImageToPDF;
