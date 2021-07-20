import Roact from "@rbxts/roact";
import { Avatar } from "shared/avatar";

interface AvatarViewportProps {
    player: Player;
    shirtId?: number;
    pantsId?: number;
}

export class AvatarViewportComponent extends Roact.Component<AvatarViewportProps, {}> {
    viewportRef = Roact.createRef<ViewportFrame>();
    avatarGenerator: Avatar;
    constructor(props: AvatarViewportProps) {
        super(props);
        this.avatarGenerator = new Avatar(props.player);
    }
    async didMount() {
        const viewport = this.viewportRef.getValue();
        if (viewport) {
            const camera = new Instance("Camera");
            camera.CFrame = CFrame.lookAt(new Vector3(0, 0, -5), new Vector3(0, 0, 0));
            camera.CameraType = Enum.CameraType.Scriptable;
            camera.FieldOfView = 70;

            const character = this.avatarGenerator.loadCharacterR6();
            print(this.props.shirtId, this.props.pantsId)
            if (this.props.shirtId)
                Avatar.changeShirt(character, this.props.shirtId);
            if (this.props.pantsId)
                Avatar.changePants(character, this.props.pantsId);

            camera.Parent = viewport;
            viewport.CurrentCamera = camera;
            character.Parent = viewport;
        }
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