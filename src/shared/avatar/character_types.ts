export type Character = Model & {
    Humanoid: Humanoid & {
        HumanoidDescription?: HumanoidDescription;
    };
    HumanoidRootPart: Part;
    Head: Part;
    Shirt?: Shirt;
    Pants?: Pants;
    ShirtGraphic?: ShirtGraphic;
}

export type R15 = Character & {
    LeftLowerArm: MeshPart & {
        LeftElbowRigAttachment: Attachment;
        LeftElbow: Motor6D;
        LeftWristRigAttachment: Attachment;
    };
    LeftFoot: MeshPart & {
        LeftAnkleRigAttachment: Attachment;
        LeftAnkle: Motor6D;
    };
    RightHand: MeshPart & {
        RightWristRigAttachment: Attachment;
        RightWrist: Motor6D;
        RightGripAttachment: Attachment;
    };
    HumanoidRootPart: Part & {
        RootRigAttachment: Attachment;
    };
    RightLowerLeg: MeshPart & {
        RightKneeRigAttachment: Attachment;
        RightAnkleRigAttachment: Attachment;
        RightKnee: Motor6D;
    };
    LeftUpperLeg: MeshPart & {
        LeftHip: Motor6D;
        LeftHipRigAttachment: Attachment;
        LeftKneeRigAttachment: Attachment;
    };
    LeftLowerLeg: MeshPart & {
        LeftKnee: Motor6D;
        LeftAnkleRigAttachment: Attachment;
        LeftKneeRigAttachment: Attachment;
    };
    LowerTorso: MeshPart & {
        WaistBackAttachment: Attachment;
        WaistCenterAttachment: Attachment;
        RootRigAttachment: Attachment;
        RightHipRigAttachment: Attachment;
        Root: Motor6D;
        WaistRigAttachment: Attachment;
        LeftHipRigAttachment: Attachment;
        WaistFrontAttachment: Attachment;
    };
    Head: Part & {
        FaceFrontAttachment: Attachment;
        HatAttachment: Attachment;
        Neck: Motor6D;
        NeckRigAttachment: Attachment;
        HairAttachment: Attachment;
        face: Decal;
        Mesh: SpecialMesh;
        FaceCenterAttachment: Attachment;
    };
    UpperTorso: MeshPart & {
        RightCollarAttachment: Attachment;
        BodyBackAttachment: Attachment;
        NeckRigAttachment: Attachment;
        LeftCollarAttachment: Attachment;
        Waist: Motor6D;
        RightShoulderRigAttachment: Attachment;
        BodyFrontAttachment: Attachment;
        WaistRigAttachment: Attachment;
        LeftShoulderRigAttachment: Attachment;
        NeckAttachment: Attachment;
    };
    LeftUpperArm: MeshPart & {
        LeftElbowRigAttachment: Attachment;
        LeftShoulderRigAttachment: Attachment;
        LeftShoulder: Motor6D;
        LeftShoulderAttachment: Attachment;
    };
    RightLowerArm: MeshPart & {
        RightWristRigAttachment: Attachment;
        RightElbow: Motor6D;
        RightElbowRigAttachment: Attachment;
    };
    LeftHand: MeshPart & {
        LeftWrist: Motor6D;
        LeftGripAttachment: Attachment;
        LeftWristRigAttachment: Attachment;
    };
    RightUpperArm: MeshPart & {
        RightShoulder: Motor6D;
        RightShoulderRigAttachment: Attachment;
        RightShoulderAttachment: Attachment;
        RightElbowRigAttachment: Attachment;
    };
    RightUpperLeg: MeshPart & {
        RightKneeRigAttachment: Attachment;
        RightHip: Motor6D;
        RightHipRigAttachment: Attachment;
    };
    RightFoot: MeshPart & {
        RightAnkle: Motor6D;
        RightAnkleRigAttachment: Attachment;
    };
}
export type R6 = Character & {
    ["Left Leg"]: Part;
    ["Right Arm"]: Part & {
        RightShoulderAttachment: Attachment;
    };
    Head: Part & {
        HatAttachment: Attachment;
        HairAttachment: Attachment;
        FaceFrontAttachment: Attachment;
        face: Decal;
        Mesh: SpecialMesh;
        FaceCenterAttachment: Attachment;
    };
    ["Right Leg"]: Part;
    Torso: Part & {
        ["Left Shoulder"]: Motor6D;
        WaistCenterAttachment: Attachment;
        BodyBackAttachment: Attachment;
        Neck: Motor6D;
        ["Right Hip"]: Motor6D;
        WaistBackAttachment: Attachment;
        roblox: Decal;
        LeftCollarAttachment: Attachment;
        NeckAttachment: Attachment;
        RightCollarAttachment: Attachment;
        BodyFrontAttachment: Attachment;
        ["Left Hip"]: Motor6D;
        ["Right Shoulder"]: Motor6D;
        WaistFrontAttachment: Attachment;
    };
    HumanoidRootPart: Part & {
        RootJoint: Motor6D;
    };
    ["Left Arm"]: Part & {
        LeftShoulderAttachment: Attachment;
    };
}

export function getR6(): R6 {
    const character = script.Parent?.FindFirstChild("models")?.FindFirstChild("R6") as R6 | undefined;
    if (character)
        return character.Clone();
    else
        throw "Rig not found!"
}

export function getR15(): R15 {
    const character = script.Parent?.FindFirstChild("models")?.FindFirstChild("R15") as R15 | undefined;
    if (character)
        return character.Clone();
    else
        throw "Rig not found!"
}