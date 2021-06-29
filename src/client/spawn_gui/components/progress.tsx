import Roact, { Element } from "@rbxts/roact";

interface Props {
    items: Element[];
}

export class ProgressComponent extends Roact.Component<Props, {}> {
    render() {
        const items = this.props.items.map(item => item);
        items.push(<uilistlayout
            FillDirection={Enum.FillDirection.Horizontal}
            HorizontalAlignment={Enum.HorizontalAlignment.Center}
            Padding={new UDim(0.1, 0)}
            SortOrder={Enum.SortOrder.LayoutOrder}
        />);
        return Roact.createElement("Frame", {
            Name: "List",
            BackgroundTransparency: 1,
            Position: new UDim2(0.3, 70, 0, 0),
            Size: new UDim2(0.7, -70, 0, 36)
        }, items);
    }
}