import { History } from 'history';
import { Provider } from 'mobx-react';
import * as React from 'react';
import { ApiStore } from '../stores/apiStore';
import { HolidayStore } from '../stores/holidayStore';
import { MainStore } from '../stores/mainStore';
import { MissionStore } from '../stores/missionStore';
import { PaymentStore } from '../stores/paymentStore';
import { ReportSheetStore } from '../stores/reportSheetStore';
import { SpecificationStore } from '../stores/specificationStore';
import { UserFeedbackStore } from '../stores/userFeedbackStore';
import { UserStore } from '../stores/userStore';
import { Formatter } from './formatter';

interface Props {
  history: History;
}

export class StoreProvider extends React.Component<Props> {
  private stores: {
    apiStore: ApiStore;
    mainStore: MainStore;
    holidayStore: HolidayStore;
    paymentStore: PaymentStore;
    reportSheetStore: ReportSheetStore;
    userFeedbackStore: UserFeedbackStore;
    userStore: UserStore;
    missionStore: MissionStore;
    specificationStore: SpecificationStore;
  };

  constructor(props: Props) {
    super(props);

    const apiStore = new ApiStore(this.props.history);
    const formatter = new Formatter();
    const mainStore = new MainStore(apiStore, formatter, this.props.history);

    this.stores = {
      apiStore,
      mainStore,
      holidayStore: new HolidayStore(mainStore),
      paymentStore: new PaymentStore(mainStore),
      reportSheetStore: new ReportSheetStore(mainStore),
      userFeedbackStore: new UserFeedbackStore(mainStore),
      userStore: new UserStore(mainStore),
      missionStore: new MissionStore(mainStore),
      specificationStore: new SpecificationStore(mainStore),
    };
  }
  render() {
    return <Provider {...this.stores}>{this.props.children}</Provider>;
  }
}
