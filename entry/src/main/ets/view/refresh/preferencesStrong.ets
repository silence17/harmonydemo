import dataPreferences from '@ohos.data.preferences';

const STORE_NAME = "baseInfo"

let context = getContext(this)
let preference: dataPreferences.Preferences

export class PreferenceUtil {
  async getPreferences() {
    try {
      preference = await dataPreferences.getPreferences(context, STORE_NAME)
    }
    catch (err) {
      console.error(`error:${err}`)
    }
  }

  async deletePreferences() {
    try {
      await dataPreferences.deletePreferences(context, STORE_NAME);
    } catch(err) {
      console.error('TAG', `Failed to delete preferences, Cause: ${err}`);
    };
  }

  async putPreference(key: string, value: string) {
    if (!key || !value) {
      return
    }

    if (!preference) {
      await this.getPreferences();
    }
    // The fruit name and fruit quantity data entered by the user are saved to the cached Preference instance.
    try {
      await preference.put(key, value);
    } catch (err) {
      console.error('TAG', `Failed to put value, Cause: ${err}`);
    }
    // Store the Preference instance in the preference persistence file
    await preference.flush();
  }

  /**
   * Get preference data.
   */
  async getPreference(key: string) {
    if (!key) {
      return
    }

    let value: number | string | boolean | Array<number> | Array<string> | Array<boolean>;
    if (!preference) {
      await this.getPreferences();
    }
    try {
      value = await preference.get(key, '')
    } catch (err) {
      console.error('TAG', `Failed to get value, Cause: ${err}`)
    }
    // If the data is empty, a message is displayed indicating that data needs to be written.
    if (value === '') {
      return
    }

    return value;
  }
}

export default new PreferenceUtil();
