import * as React from 'react';
import { inject, observer } from 'mobx-react';
import { HolidayStore } from '../stores/holidayStore';
import { RouteComponentProps } from 'react-router';
import IziviContent from '../layout/IziviContent';
import Table from 'reactstrap/lib/Table';
import { MainStore } from 'src/stores/mainStore';
import { Column, Holiday } from 'src/types';
import { TextField, DatePickerField, SelectField } from 'src/form/common';
import { Field, Formik, FormikActions } from 'formik';
import Button from 'reactstrap/lib/Button';
import { apiDate } from '../utilities/validationHelpers';
import * as yup from 'yup';
import moment from 'moment';

const holidaySchema = yup.object({
  date_from: apiDate().required(),
  date_to: apiDate().required(),
  holiday_type_id: yup.number().required(),
  description: yup.string().required(),
});

interface Props extends RouteComponentProps {
  holidayStore?: HolidayStore;
  mainStore?: MainStore;
}

@inject('holidayStore', 'mainStore')
@observer
export class HolidayOverview extends React.Component<Props> {
  public columns: Array<Column<Holiday>> = [];

  constructor(props: Props) {
    super(props);
    this.props.holidayStore!.fetchAll().then(() => {
      this.setState({ loading: false });
    });

    this.state = {
      loading: true,
    };

    this.columns = [
      {
        id: 'date_from',
        numeric: false,
        label: 'Datum Start',
        format: h => this.props.mainStore!.formatDate(h.date_from),
      },
      {
        id: 'date_to',
        numeric: false,
        label: 'Datum Ende',
        format: h => this.props.mainStore!.formatDate(h.date_to),
      },
      {
        id: 'holiday_type_id',
        numeric: false,
        label: 'Type',
      },
      {
        id: 'description',
        numeric: false,
        label: 'Beschreibung',
      },
      {
        id: 'save',
        numeric: false,
        label: '',
      },
      {
        id: 'delete',
        numeric: false,
        label: '',
      },
    ];
  }

  handleSubmit = async (entity: Holiday, actions: FormikActions<Holiday>) => {
    this.props.holidayStore!.put(holidaySchema.cast(entity)).then(() => actions.setSubmitting(false));
  };

  handleAdd = async (entity: Holiday, actions: FormikActions<Holiday>) => {
    await this.props.holidayStore!.post(holidaySchema.cast(entity)).then(() => {
      actions.setSubmitting(false);
      actions.resetForm();
    });
  };

  render() {
    const entities = this.props.holidayStore!.entities;
    const holidayStore = this.props.holidayStore!;

    return (
      <IziviContent>
        <Table>
          <thead>
            <tr>
              {this.columns.map(col => (
                <th key={col.id}>{col.label}</th>
              ))}
            </tr>
          </thead>
          <tbody>
            <Formik
              validationSchema={holidaySchema}
              initialValues={{
                date_from: moment().format('Y-MM-DD'),
                date_to: moment().format('Y-MM-DD'),
                holiday_type_id: 2,
                description: '',
              }}
              onSubmit={this.handleAdd}
              render={formikProps => (
                <tr>
                  <td>
                    <Field component={DatePickerField} name={'date_from'} />
                  </td>
                  <td>
                    <Field component={DatePickerField} name={'date_to'} />
                  </td>
                  <td>
                    <Field
                      component={SelectField}
                      name={'holiday_type_id'}
                      options={[{ id: '1', name: 'Betriebsferien' }, { id: '2', name: 'Feiertag' }]}
                    />
                  </td>
                  <td>
                    <Field component={TextField} name={'description'} />
                  </td>
                  <td>
                    <Button color={'success'} disabled={formikProps.isSubmitting} onClick={formikProps.submitForm}>
                      Hinzufügen
                    </Button>
                  </td>
                  <td />
                </tr>
              )}
            />
            {entities.map(holiday => (
              <Formik
                key={holiday.id}
                validationSchema={holidaySchema}
                initialValues={holiday}
                onSubmit={this.handleSubmit}
                render={formikProps => (
                  <tr>
                    <td>
                      <Field component={DatePickerField} name={'date_from'} />
                    </td>
                    <td>
                      <Field component={DatePickerField} name={'date_to'} />
                    </td>
                    <td>
                      <Field
                        component={SelectField}
                        name={'holiday_type_id'}
                        options={[{ id: '1', name: 'Betriebsferien' }, { id: '2', name: 'Feiertag' }]}
                      />
                    </td>
                    <td>
                      <Field component={TextField} name={'description'} />
                    </td>
                    <td>
                      <Button color={'success'} disabled={formikProps.isSubmitting} onClick={formikProps.submitForm}>
                        Speichern
                      </Button>
                    </td>
                    <td>
                      <Button
                        color={'danger'}
                        disabled={formikProps.isSubmitting}
                        onClick={() => {
                          holidayStore!.delete(holiday.id!);
                        }}
                      >
                        Löschen
                      </Button>
                    </td>
                  </tr>
                )}
              />
            ))}
          </tbody>
        </Table>
      </IziviContent>
    );
  }
}
