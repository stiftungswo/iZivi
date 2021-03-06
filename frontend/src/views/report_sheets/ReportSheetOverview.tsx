import { inject, observer } from 'mobx-react';
import * as React from 'react';
import { Link } from 'react-router-dom';
import Button from 'reactstrap/lib/Button';
import ButtonGroup from 'reactstrap/lib/ButtonGroup';
import IziviContent from '../../layout/IziviContent';
import { OverviewTable } from '../../layout/OverviewTable';
import { MainStore } from '../../stores/mainStore';
import { ReportSheetStore } from '../../stores/reportSheetStore';
import { Column, ReportSheetListing } from '../../types';
import { ReportSheetStatisticFormDialog } from './ReportSheetStatisticFormDialog';

interface Props {
  mainStore?: MainStore;
  reportSheetStore?: ReportSheetStore;
}

interface State {
  loading: boolean;
  modalOpen: boolean;
  reportSheetStateFilter: string | null;
}

@inject('mainStore', 'reportSheetStore')
@observer
export class ReportSheetOverview extends React.Component<Props, State> {
  columns: Array<Column<ReportSheetListing>>;

  constructor(props: Props) {
    super(props);
    this.columns = [
      {
        id: 'zdp',
        label: 'ZDP',
        format: (r: ReportSheetListing) => r.user.zdp,
      },
      {
        id: 'first_name',
        label: 'Name',
        format: (r: ReportSheetListing) => (
          <Link to={'/users/' + r.user_id!}>{r.user.first_name} {r.user.last_name}</Link>
        ),
      },
      {
        id: 'start',
        label: 'Von',
        format: (r: ReportSheetListing) => this.props.mainStore!.formatDate(r.start),
      },
      {
        id: 'end',
        label: 'Bis',
        format: (r: ReportSheetListing) => this.props.mainStore!.formatDate(r.end),
      },
    ];

    this.state = {
      loading: true,
      modalOpen: false,
      reportSheetStateFilter: 'pending',
    };
  }

  componentDidMount(): void {
    this.loadContent();
  }

  loadContent = () => {
    this.props.reportSheetStore!.fetchAll({ state: this.state.reportSheetStateFilter }).then(() => this.setState({ loading: false }));
  }

  updateSheetFilter = (state: string | null) => {
    this.setState({ loading: true, reportSheetStateFilter: state }, () => this.loadContent());
  }

  render() {
    return (
      <IziviContent card loading={this.state.loading} title={'Spesen'}>
        <Button outline onClick={() => this.toggle()}>
          Spesenstatistik generieren
        </Button>{' '}
        <br /> <br />
        <ButtonGroup>
          <Button
            outline={this.state.reportSheetStateFilter !== null}
            color={this.state.reportSheetStateFilter === null ? 'primary' : 'secondary'}
            onClick={() => this.updateSheetFilter(null)}
          >
            Alle Spesenblätter
          </Button>
          <Button
            outline={this.state.reportSheetStateFilter !== 'pending'}
            color={this.state.reportSheetStateFilter === 'pending' ? 'primary' : 'secondary'}
            onClick={() => this.updateSheetFilter('pending')}
          >
            Pendente Spesenblätter
          </Button>
          <Button
            outline={this.state.reportSheetStateFilter !== 'current'}
            color={this.state.reportSheetStateFilter === 'current' ? 'primary' : 'secondary'}
            onClick={() => this.updateSheetFilter('current')}
          >
            Aktuelle Spesenblätter
          </Button>
        </ButtonGroup>
        <ReportSheetStatisticFormDialog isOpen={this.state.modalOpen} mainStore={this.props.mainStore!} toggle={() => this.toggle()} />
        <br /> <br />
        <OverviewTable
          columns={this.columns}
          data={this.props.reportSheetStore!.reportSheets}
          renderActions={(e: ReportSheetListing) => <Link to={'/report_sheets/' + e.id}>Spesenblatt bearbeiten</Link>}
        />
      </IziviContent>
    );
  }

  protected toggle() {
    this.setState({ modalOpen: !this.state.modalOpen });
  }
}
