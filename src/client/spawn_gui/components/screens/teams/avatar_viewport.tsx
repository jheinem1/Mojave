import Roact from "@rbxts/roact";

export class AvatarViewportComponent extends Roact.Component {
    viewportRef = Roact.createRef<ViewportFrame>();
    didMount() {
        
    }
    render() {
        return <viewportframe
            Key="Avatar"
            Ambient={Color3.fromRGB(106, 106, 106)}
            BackgroundTransparency={1}
            LightColor={Color3.fromRGB(255, 255, 255)}
            LightDirection={new Vector3(2, -1, -1)}
            Size={new UDim2(1, 0, 1, 0)}
            ZIndex={2}
            Visible={true}
            Ref={this.viewportRef}
        />
    }
}