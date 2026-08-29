#pragma once

#include <filesystem>
#include <mutex>
#include <string>

#include <pl/Mod.hpp>

struct BloomConfig {
    bool enabled = true;
    float intensity = 0.65f;
    float radius = 0.18f;
    int layers = 5;
    int max_instances = 96;
    bool affect_particles = true;
    bool affect_entities = true;
    bool affect_blocks = true;
};

class LeviBloomMod {
public:
    static LeviBloomMod &instance();

    LeviBloomMod();
    bool load();
    bool enable();
    bool disable();
    bool unload();

    ll::mod::NativeMod &self() const { return mSelf; }

private:
    void loadConfig();
    void saveConfig();

    ll::mod::NativeMod &mSelf;
    BloomConfig mConfig{};
    std::mutex mMutex;
};
