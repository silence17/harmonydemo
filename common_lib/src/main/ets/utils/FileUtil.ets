import fs from '@ohos.file.fs';
import File from '@system.file';
import { Log } from './Log/Log';

class FileUtils {
  static async writeFile(data: string, filePath: string) {

    let file = await fs.open(filePath, fs.OpenMode.READ_WRITE);
    fs.write(file.fd, data)
      .then((writeLen) => {
        fs.close(file);
      }).catch((err) => {
      Log.error(`Failed to write data. Code is ${err.code}, message is ${err.message}`)
    })
  }
}