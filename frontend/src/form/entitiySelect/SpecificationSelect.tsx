import { inject, observer } from 'mobx-react';
import React from 'react';
import FormGroup from 'reactstrap/lib/FormGroup';
import Input from 'reactstrap/lib/Input';
import Label from 'reactstrap/lib/Label';
import { SpecificationStore } from '../../stores/specificationStore';
import { Specification } from '../../types';
import { IziviCustomFieldProps, withColumn } from '../common';

type Props = {
  specificationStore?: SpecificationStore;
  label?: string;
  required?: boolean;
  horizontal?: boolean;
} & IziviCustomFieldProps<string>;

@inject('specificationStore')
@observer
export class SpecificationSelect extends React.Component<Props> {
  get options() {
    return this.props
      .specificationStore!.entities.filter((sp: Specification) => sp.active)
      .map(e => ({
        value: e.id,
        label: e.name,
      }));
  }

  render() {
    const { name, value, onChange, label, horizontal, required } = this.props;

    const SpecificationSelectInner = () => (
      <Input value={value} onChange={e => onChange(e.target.value)} type={'select'}>
        <option value="" />
        {this.options.map(option => (
          <option value={option.value} key={option.value}>
            {option.label}
          </option>
        ))}
      </Input>
    );

    return (
      <FormGroup row={horizontal}>
        <Label for={name} md={horizontal ? 3 : undefined}>
          {label} {required && '*'}
        </Label>
        {horizontal && withColumn()(<SpecificationSelectInner />)}
        {!horizontal && <SpecificationSelectInner />}
      </FormGroup>
    );
  }
}
