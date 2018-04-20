import Card from '../tags/card';
import axios from 'axios';
import { Component } from 'inferno';
import ApiService from '../../utils/api';
import LoadingView from '../tags/loading-view';
import Header from '../tags/header';

export default class ChangePassword extends Component {
  constructor(props) {
    super(props);

    this.state = {
      old_password: '',
      new_password: '',
      new_password_2: '',
    };
  }

  save() {
    this.setState({ loading: true, error: null });
    let errorMsg = [];
    let errorBox = [];
    let confirmBox = [];

    axios
      .post(
        ApiService.BASE_URL + 'postChangePassword',
        {
          old_password: this.state.old_password,
          new_password: this.state.new_password,
          new_password_2: this.state.new_password_2,
        },
        { headers: { Authorization: 'Bearer ' + localStorage.getItem('jwtToken') } }
      )
      .then(response => {
        errorMsg = [];
        errorBox = [];
        confirmBox = [];

        confirmBox.push(
          <div class="alert alert-success">
            <strong>Änderung Erfolgreich!</strong>
            <br />Ihr Passwort wurde geändert.
          </div>
        );

        this.setState({ errorBox: errorBox, confirmBox: confirmBox, loading: false });
      })
      .catch(error => {
        errorMsg = [];

        if (error.response != null && error.response.data != null) {
          for (let item in error.response.data) {
            errorMsg.push(
              <p>
                {item}: {error.response.data[item]}
              </p>
            );
          }
        }

        errorBox = [];
        confirmBox = [];
        errorBox.push(
          <div class="alert alert-danger">
            <strong>Passwort konnte nicht geändert werden.</strong>
            <br />
            {errorMsg}
          </div>
        );

        this.setState({ errorBox: errorBox, confirmBox: confirmBox, loading: false });
      });
  }

  redirectBack(e) {
    window.history.back();
  }

  handleChange(e) {
    let value = e.target.value;
    this.state[e.target.name] = value;
    this.setState(this.state);
  }

  handleSecondPWChange(e) {
    var targetSelect = document.getElementById(e.target.id);
    let value = targetSelect.options[targetSelect.selectedIndex].value;
    this.state[e.target.name] = value;
    this.setState(this.state);
  }

  render() {
    return (
      <Header>
        <div className="page page__user_list">
          <Card>
            <h1>Passwort Ändern</h1>
            {this.state.errorBox}
            {this.state.confirmBox}
            <div class="container">
              <form
                id="changePasswordForm"
                action="javascript:;"
                class="form-horizontal"
                data-toggle="validator"
                onsubmit={() => {
                  this.save();
                }}
              >
                <hr />
                <input name="id" value="00000" type="hidden" />
                <button type="button" name="back" class="btn btn-primary" onClick={e => this.redirectBack(e)}>
                  Abbrechen
                </button>
                <hr />

                <h3>Passwort</h3>

                <div class="form-group has-feedback">
                  <label class="control-label col-sm-3" for="old_password">
                    Altes Passwort
                  </label>
                  <div class="col-sm-9">
                    <input
                      type="password"
                      id="old_password"
                      name="old_password"
                      value={this.state.old_password}
                      onInput={e => this.handleChange(e)}
                      className="form-control"
                      required
                    />
                  </div>
                </div>

                <div class="form-group has-feedback">
                  <label class="control-label col-sm-3" for="old_password">
                    Neues Passwort
                  </label>
                  <div class="col-sm-9">
                    <input
                      type="password"
                      id="new_password"
                      name="new_password"
                      value={this.state.new_password}
                      onInput={e => this.handleChange(e)}
                      className="form-control"
                      data-minlength="7"
                      placeholder=""
                      required
                    />
                  </div>
                  <div class="col-sm-3" />
                  <div class="help-block col-sm-9">Mindestens 7 Zeichen</div>
                </div>

                <div class="form-group has-feedback">
                  <label class="control-label col-sm-3" for="old_password">
                    Wiederholen
                  </label>
                  <div class="col-sm-9">
                    <input
                      type="password"
                      id="new_password_2"
                      name="new_password_2"
                      value={this.state.new_password_2}
                      onInput={e => this.handleChange(e)}
                      className="form-control"
                      data-match="#new_password"
                      data-match-error="Die beiden Eingaben stimmen nicht überein"
                      placeholder=""
                      required
                    />
                  </div>
                  <div class="col-sm-3" />
                  <div class="help-block with-errors col-sm-9" />
                </div>

                <button type="submit" class="btn btn-primary">
                  Absenden
                </button>
              </form>
            </div>
          </Card>
          <LoadingView loading={this.state.loading} error={this.state.error} />
        </div>
      </Header>
    );
  }

  //initialize validation after render
  componentDidUpdate() {
    window.$('#changePasswordForm').validator();
  }
}
