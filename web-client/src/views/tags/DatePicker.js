import Inferno from 'inferno';
import { Link } from 'inferno-router';
import Component from 'inferno-component';
import { connect } from 'inferno-mobx'
import InputField from '../tags/InputField';

export default class DatePicker extends InputField {

    static dateFormat_EN2CH(value) {
        return moment(value).format("DD.MM.YYYY");
    }

    static dateFormat_CH2EN(value) {
        return moment(value, "DD.MM.YYYY").format("YYYY-MM-DD");
    }

    render() {
        let dateValue = this.props.value;
        if(dateValue === undefined || parseInt(dateValue) == 0) {
            dateValue = null;
        }
        else {
            dateValue = DatePicker.dateFormat_EN2CH(this.props.value);
        }

        return this.getFormGroup (
            <div class="input-group input-append date datePicker" id="datePicker">
                <input
                    type="text"
                    class="form-control"
                    id={this.props.id}
                    name={this.props.id}
                    value={dateValue}
                    onChange={(e)=>this.props.callback(e, this.props.callbackOrigin)}
                />
                <span class="input-group-addon add-on">
                    <span class="glyphicon glyphicon-calendar"></span>
                </span>
            </div>
        )
    }
}



