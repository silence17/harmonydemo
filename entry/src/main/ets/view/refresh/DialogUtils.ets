import Context from '@ohos.app.ability.common';

/**
 * This is a pop-up window tool class, which is used to encapsulate dialog code.
 * Developers can directly invoke the methods in.
 */
export class CommonUtils {
  /**
   * Alert dialog dialog
   */
  alertDialog(context: Context.UIAbilityContext) {
    AlertDialog.show({
      message: $r('app.string.alert_dialog_message'),
      alignment: DialogAlignment.Bottom,
      offset: {
        dx: 0,
        dy: -20
      },
      primaryButton: {
        value: $r('app.string.cancel_button'),
        action: () => {
          console.info('Callback cancel button is clicked');
        }
      },
      secondaryButton: {
        value: $r('app.string.definite_button'),
        action: () => {
          // Exiting the app.
          context.terminateSelf();
          console.info('Callback definite button is clicked');
        }
      }
    });
  }


  /**
   * Date dialog dialog
   */
  static  datePickerDialog(dateCallback: Function) {
    let date = new Date();
    let year = date.getFullYear();
    let month = date.getMonth() + 1;
    let day = date.getDate();
    const birthdate = this.getBirthDateValue(year, month, day);
    DatePickerDialog.show({
      start: new Date('1900-1-1'),
      end: new Date(),
      selected: new Date('1900-1-1'),
      lunar: false,
      onAccept: (value: DatePickerResult) => {
        let year: number = Number(value.year);
        let month: number = Number(value.month) + 1;
        let day: number = Number(value.day);
        let birthdate: string = this.getBirthDateValue(year, month, day);
        dateCallback(birthdate);
      }
    });
  }

  /**
   * Text dialog dialog
   */
 static  textPickerDialog(sexArray: Resource, sexCallback: Function) {
    if (this.isEmpty(sexArray)) {
      console.error('sex is null');
      return;
    }
    TextPickerDialog.show({
      range: sexArray,
      selected: 0,
      onAccept: (result: TextPickerResult) => {
        sexCallback(result.value);
      },
      onCancel: () => {
        console.info('TextPickerDialog onCancel');
      }
    });
  }

  /**
   * Get default birth date
   *
   * @param {number} year year
   * @param {number} month month
   * @param {number} day day
   * @returns {string} return birth date
   */
  static  getBirthDateValue(year: number, month: number, day: number): string {
    let birthdate: string = `${year}年${month}` + `月${day}日`;
    return birthdate;
  }

  /**
   * Check obj is empty
   *
   * @param {object} obj
   * @return {boolean} true(empty)
   */
  static  isEmpty(obj: object | string): boolean {
    return obj === undefined || obj === null || obj === '';
  }

  /**
   * Check array is empty
   *
   * @param {Array}array
   * @return {boolean} true(empty)
   */
 static  isEmptyArr(array: Array<any>): boolean {
    return this.isEmpty(array) || array.length === 0;
  }
}

export default new CommonUtils();