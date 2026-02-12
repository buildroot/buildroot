import gymnasium as gym
env = gym.make("CartPole-v1")

observation, info = env.reset()
random_action = env.action_space.sample()
next_observation, reward, terminated, truncated, info = env.step(random_action)

env.close()
