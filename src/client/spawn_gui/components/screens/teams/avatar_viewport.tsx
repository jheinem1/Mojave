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
    didMount() {
        const viewport = this.viewportRef.getValue();
        if (viewport) {
            const camera = new Instance("Camera");
            camera.CFrame = new CFrame();
            camera.Parent = viewport;
            viewport.CurrentCamera = camera;

            const character = this.avatarGenerator.loadCharacter();
            if (this.props.shirtId)
                this.avatarGenerator.changeShirt(character, this.props.shirtId);
            if (this.props.pantsId)
                this.avatarGenerator.changePants(character, this.props.pantsId);
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